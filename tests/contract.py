from pathlib import Path

import yaml
from jsonschema import Draft202012Validator
from openapi_spec_validator import validate


ROOT = Path(__file__).resolve().parents[1]
SPEC = yaml.safe_load((ROOT / "openapi.yaml").read_text(encoding="utf-8"))


def validate_payload(schema, payload):
    Draft202012Validator(
        {"components": SPEC["components"], **schema},
        format_checker=Draft202012Validator.FORMAT_CHECKER,
    ).validate(payload)


def validate_model(name, payload):
    validate_payload({"$ref": f"#/components/schemas/{name}"}, payload)


def validate_examples(node):
    if isinstance(node, list):
        return sum(validate_examples(item) for item in node)
    if not isinstance(node, dict):
        return 0

    checked = 0
    media_type = node.get("content", {}).get("application/json", {})
    if "schema" in media_type:
        examples = [entry["value"] for entry in media_type.get("examples", {}).values()]
        if "example" in media_type:
            examples.append(media_type["example"])
        for example in examples:
            validate_payload(media_type["schema"], example)
        checked += len(examples)
    return checked + sum(validate_examples(value) for value in node.values())


if __name__ == "__main__":
    validate(SPEC)
    for schema in SPEC["components"]["schemas"].values():
        Draft202012Validator.check_schema(schema)
    print(f"OpenAPI {SPEC['openapi']} and {validate_examples(SPEC)} JSON examples passed.")
