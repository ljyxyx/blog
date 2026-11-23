// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  // 上线到 GitHub Pages 后，把下面这行改成你的地址，例如：
  // site: 'https://yourname.github.io',
  markdown: {
    shikiConfig: { theme: 'github-light' },
  },
});
