import { writeFile } from "node:fs/promises";
import { setTimeout as delay } from "node:timers/promises";
import { Configuration, MusicApi } from "openmusic-sdk";

function requiredEnvironment(name: string): string {
  const value = process.env[name];
  if (!value) {
    throw new Error(`Set ${name} before running this example.`);
  }
  return value;
}

async function main() {
  const api = new MusicApi(new Configuration({
    basePath: requiredEnvironment("OPENMUSIC_BASE_URL").replace(/\/+$/, ""),
    accessToken: requiredEnvironment("OPENMUSIC_TOKEN"),
  }));

  const modelId = process.env.OPENMUSIC_MODEL;
  if (!modelId) {
    const models = await api.listMusicModels();
    for (const model of models.data) {
      console.log(model.id);
    }
    return;
  }

  const model = await api.getMusicModel({ modelId });
  if (!model.supportedParameters.includes("prompt")) {
    throw new Error(`Model ${modelId} does not accept a prompt.`);
  }

  let task = await api.createMusicTask({
    musicRequest: {
      model: modelId,
      prompt: "A gentle acoustic instrumental with piano and guitar",
    },
  });
  console.log(`Task ${task.id}`);

  for (let attempt = 0; attempt < 150; attempt++) {
    if (task.status !== "queued" && task.status !== "in_progress") {
      break;
    }
    await delay(2_000);
    task = await api.getMusicTask({ id: task.id });
  }
  if (task.status !== "completed") {
    throw new Error(task.error?.message ?? `Task ${task.id} is ${task.status}.`);
  }

  const track = task.data?.[0];
  if (!track) {
    throw new Error(`Task ${task.id} returned no tracks.`);
  }
  const audio = await api.downloadMusicTrack({ id: task.id, trackId: track.id });
  const bytes = await audio.arrayBuffer();
  if (!bytes.byteLength) {
    throw new Error(`Track ${track.id} returned no audio.`);
  }

  const format = track.format?.match(/^[a-z0-9]+$/i)?.[0] ?? "audio";
  const safeId = task.id.replace(/[^a-z0-9_-]/gi, "_");
  const filename = `${safeId}.${format}`;
  await writeFile(filename, Buffer.from(bytes));
  console.log(`Saved ${filename}`);
}

main().catch((error: unknown) => {
  console.error(error instanceof Error ? error.message : error);
  process.exitCode = 1;
});
