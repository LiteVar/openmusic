import base64
import json
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs, urlsplit

from contract import validate_model


TOKEN = "openmusic-test-token"
MODEL_ID = "example/studio-v1"
TIMESTAMP = 1795680000
AUDIO = base64.b64decode("UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAAAA/4B/")
COLLECTION = "/v1/music"
MODEL = {
    "id": MODEL_ID,
    "object": "model",
    "name": "Studio v1",
    "type": "music",
    "supported_parameters": ["prompt", "lyrics", "duration", "instrumental", "n"],
    "capabilities": {
        "prompt": {"type": "string", "support": "native"},
        "lyrics": {"type": "string", "support": "native"},
        "duration": {
            "type": "number",
            "support": "native",
            "unit": "seconds",
            "default_value": {"number": 60},
        },
        "instrumental": {
            "type": "boolean",
            "support": "native",
            "default_value": {"boolean": False},
        },
        "n": {"type": "integer", "support": "native", "min": 1, "max": 2},
    },
    "constraints": [
        {
            "when": [{"parameter": "instrumental", "operator": "equals", "value": {"boolean": True}}],
            "require": ["prompt"],
        },
    ],
    "features": {"text_to_music": True, "lyrics_to_music": True, "cancellation": True},
    "provider_options": {
        "example": {
            "options": {
                "guidance_scale": {"type": "number", "support": "native"},
                "composition": {"type": "object", "support": "native"},
            },
        },
    },
}


class MockService(HTTPServer):
    def __init__(self):
        super().__init__(("127.0.0.1", 0), MusicHandler)
        self.tasks = {}
        self.requests = {}
        self.keys = {}


class MusicHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass

    def respond(self, status, body=b"", content_type=None, headers=None):
        self.send_response(status)
        if content_type:
            self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        for name, value in (headers or {}).items():
            self.send_header(name, value)
        self.end_headers()
        self.wfile.write(body)

    def respond_json(self, status, schema, value, headers=None):
        validate_model(schema, value)
        self.respond(status, json.dumps(value).encode("utf-8"), "application/json", headers)

    def error(self, status, code, param=None):
        error = {"code": code, "message": code.replace("_", " ")}
        if param:
            error["param"] = param
        self.respond_json(status, "ErrorResponse", {"error": error})

    def authorize(self):
        if self.headers.get("Authorization") == f"Bearer {TOKEN}":
            return True
        self.error(401, "unauthorized")
        return False

    def task(self, task_id):
        task = self.server.tasks.get(task_id)
        if task is None:
            self.error(404, "task_not_found")
        return task

    def do_GET(self):
        if not self.authorize():
            return
        url = urlsplit(self.path)
        if url.path == f"{COLLECTION}/models":
            self.respond_json(200, "MusicModelList", {"object": "list", "data": [MODEL]})
        elif url.path.startswith(f"{COLLECTION}/models/"):
            if url.path != f"{COLLECTION}/models/example%2Fstudio-v1":
                self.error(404, "model_not_found")
                return
            self.respond_json(200, "MusicModel", MODEL)
        elif url.path == COLLECTION:
            tasks = list(reversed(self.server.tasks.values()))
            self.respond_json(200, "MusicTaskList", {"object": "list", "data": tasks})
        elif url.path.startswith(f"{COLLECTION}/"):
            task_id, _, operation = url.path.removeprefix(f"{COLLECTION}/").partition("/")
            task = self.task(task_id)
            if task is None:
                return
            if operation == "content":
                self.download(task, parse_qs(url.query).get("track_id", [None])[0])
            elif not operation:
                self.poll(task)
            else:
                self.error(404, "not_found")
        else:
            self.error(404, "not_found")

    def do_POST(self):
        if not self.authorize():
            return
        path = urlsplit(self.path).path
        if path == COLLECTION:
            self.create()
        elif path.startswith(f"{COLLECTION}/") and path.endswith("/cancel"):
            task = self.task(path.split("/")[3])
            if task is None:
                return
            if task["status"] in ("completed", "failed"):
                self.error(409, "task_not_cancellable")
                return
            task.update(status="cancelled", progress=None)
            self.respond_json(200, "MusicTask", task)
        else:
            self.error(404, "not_found")

    def do_DELETE(self):
        if not self.authorize():
            return
        task_id = urlsplit(self.path).path.removeprefix(f"{COLLECTION}/")
        task = self.task(task_id)
        if task is None:
            return
        if task["status"] in ("queued", "in_progress"):
            self.error(409, "task_not_terminal")
            return
        del self.server.tasks[task_id]
        self.respond(204)

    def create(self):
        body = json.loads(self.rfile.read(int(self.headers["Content-Length"])))
        validate_model("MusicRequest", body)
        if body["model"] != MODEL_ID:
            self.error(404, "model_not_found", "model")
            return
        if "bpm" in body:
            self.error(400, "unsupported_parameter", "bpm")
            return
        if body.get("instrumental") is True and body.get("lyrics"):
            self.error(400, "parameter_conflict", "lyrics")
            return

        key = self.headers.get("Idempotency-Key")
        task_id = self.server.keys.get(key)
        if task_id:
            if self.server.requests[task_id] != body:
                self.error(409, "idempotency_conflict")
                return
            task = self.task(task_id)
            if task is None:
                return
        else:
            task_id = f"music_test_{len(self.server.requests) + 1}"
            task = {
                "id": task_id, "object": "music", "model": MODEL_ID, "status": "queued",
                "progress": 0, "created_at": TIMESTAMP,
            }
            self.server.tasks[task_id] = task
            self.server.requests[task_id] = body
            if key:
                self.server.keys[key] = task_id
        self.respond_json(202, "MusicTask", task, {"Location": f"{COLLECTION}/{task_id}"})

    def poll(self, task):
        task_id = task["id"]
        if task["status"] == "queued":
            task.update(status="in_progress", progress=None)
        elif task["status"] == "in_progress":
            request = self.server.requests[task_id]
            tracks = [
                {
                    "id": f"track_{index}",
                    "audio_url": f"{COLLECTION}/{task_id}/content?track_id=track_{index}",
                    "duration": 0.0005,
                    "format": "wav",
                    "sample_rate": 8000,
                    "channels": 1,
                    "lyrics": request.get("lyrics", ""),
                }
                for index in range(1, request.get("n", 1) + 1)
            ]
            task.update(
                status="completed", progress=100, completed_at=TIMESTAMP + 1, data=tracks,
                usage={"generated_tracks": len(tracks), "generated_seconds": len(tracks) * 0.0005},
            )
        self.respond_json(200, "MusicTask", task)

    def download(self, task, track_id):
        if task["status"] in ("queued", "in_progress"):
            self.error(409, "content_not_ready")
        elif task["status"] != "completed":
            self.error(409, "content_unavailable")
        elif len(task["data"]) > 1 and track_id is None:
            self.error(400, "track_id_required", "track_id")
        elif track_id is not None and not any(track["id"] == track_id for track in task["data"]):
            self.error(404, "track_not_found", "track_id")
        else:
            accept = self.headers.get("Accept", "*/*")
            if any(media in accept for media in ("audio/*", "audio/wav", "application/octet-stream", "*/*")):
                audio = AUDIO[:-4] + b"\x01\x02\x03\x04" if track_id == "track_1" else AUDIO
                self.respond(200, audio, "audio/wav")
            else:
                self.error(406, "audio_not_acceptable")
