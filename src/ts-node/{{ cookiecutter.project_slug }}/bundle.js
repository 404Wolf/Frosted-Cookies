(async () => {
  const esbuild = await import('esbuild');

  let outDir;
  if (!process.env.out)
    outDir = 'dist';
  else
    outDir = `${process.env.out}/bin`;

  const result = await esbuild.build({
    entryPoints: ['src/index.ts'],
    bundle: true,
    outdir: outDir,
  });
  console.log(result);
})()
