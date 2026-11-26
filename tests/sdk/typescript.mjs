import assert from "node:assert/strict";

const packageName = process.env.OPENMUSIC_TYPESCRIPT_PACKAGE ?? "../../sdk/typescript/dist/index.js";
const { default: sdk } = await import(packageName);
const { Configuration, MusicApi, ResponseError } = sdk;
const basePath = process.env.OPENMUSIC_TEST_URL;
const api = new MusicApi(new Configuration({ basePath, accessToken: "openmusic-test-token" }));
const modelId = "example/studio-v1";
const lyrics = "[Verse]\nLast light over the harbor";

const catalog = await api.listMusicModels();
assert.equal(catalog.data[0].id, modelId);
const model = await api.getMusicModel({ modelId });
assert.equal(model.capabilities.duration.defaultValue.number, 60);
assert.equal(model.capabilities.instrumental.defaultValue.boolean, false);
assert.deepEqual(model.constraints[0].require, ["prompt"]);

const musicRequest = {
  model: modelId,
  prompt: "Acoustic ballad",
  lyrics,
  duration: 60.5,
  instrumental: false,
  n: 2,
  provider: { options: { example: {
    guidance_scale: 4.5,
    composition: { sections: ["verse"], offset: null },
  } } },
};
const submitted = await api.createMusicTask({ musicRequest, idempotencyKey: "smoke" });
assert.equal(submitted.status, "queued");
assert.equal((await api.createMusicTask({ musicRequest, idempotencyKey: "smoke" })).id, submitted.id);
const running = await api.getMusicTask({ id: submitted.id });
assert.equal(running.status, "in_progress");
assert.equal(running.progress, null);
const completed = await api.getMusicTask({ id: submitted.id });
assert.equal(completed.status, "completed");
assert.equal(completed.data.length, 2);
assert.equal(completed.data[1].lyrics, lyrics);
assert.equal(completed.usage.generatedTracks, 2);

const audio = await api.downloadMusicTrack({ id: completed.id, trackId: completed.data[1].id });
assert.equal(audio.type, "audio/wav");
assert.equal(
  Buffer.from(await audio.arrayBuffer()).toString("base64"),
  "UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAAAA/4B/",
);
assert.equal((await api.listMusicTasks({ limit: 20 })).data[0].id, completed.id);

try {
  await api.createMusicTask({ musicRequest: { model: modelId, bpm: 120 } });
  assert.fail("Unsupported BPM should be rejected");
} catch (error) {
  assert.ok(error instanceof ResponseError);
  assert.equal(error.response.status, 400);
  assert.equal((await error.response.json()).error.code, "unsupported_parameter");
}

const pending = await api.createMusicTask({ musicRequest: { model: modelId, prompt: "Piano" } });
assert.equal((await api.cancelMusicTask({ id: pending.id })).status, "cancelled");
await api.deleteMusicTask({ id: pending.id });
