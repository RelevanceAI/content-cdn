# Replicate Media CDN

This directory contains optimized media assets for Replicate AI models organized systematically for fast delivery.

## 📁 Directory Structure

```
replicate/
├── collections/              # Collection-level media
│   ├── text-to-video.webp   # Collection cover image
│   ├── text-to-video.mp4    # Collection cover video (if exists)
│   ├── text-to-image.webp
│   ├── text-to-speech.webp
│   └── ...
└── models/                   # Model-level media
    ├── google__veo-3/        # Model folder (/ replaced with __)
    │   ├── cover.webp        # Model cover image
    │   ├── example-input-1.webp
    │   ├── example-output-1.mp4
    │   └── example-output-2.mp4
    ├── minimax__hailuo-2-3/
    │   ├── cover.webp
    │   └── example-output-1.mp4
    └── ...
```

## 🔗 URL Pattern

Media files are accessed via jsdelivr's GitHub CDN following this pattern:

- **Collection covers**: `https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/collections/{collection-slug}.webp`
- **Model covers**: `https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/models/{owner}__{model-name}/cover.webp`
- **Example media**: `https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/models/{owner}__{model-name}/example-{input|output}-{number}.{ext}`

### Examples:

```
# Collection cover
https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/collections/text-to-video.webp

# Model cover image
https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/models/google__veo-3/cover.webp

# Model example output video
https://cdn.jsdelivr.net/gh/RelevanceAI/content-cdn@latest/replicate/models/google__veo-3/example-output-1.mp4
```

## 🎨 Naming Conventions

### Model Folder Names

Model IDs are converted to folder names by replacing `/` with `__`:
- `google/veo-3` → `google__veo-3`
- `black-forest-labs/flux-1.1-pro` → `black-forest-labs__flux-1.1-pro`

This ensures filesystem compatibility while maintaining readability.

### File Names

- **Cover images**: `cover.webp`
- **Example inputs**: `example-input-{1,2,3...}.{webp|mp4}`
- **Example outputs**: `example-output-{1,2,3...}.{webp|mp4}`

## 📐 Optimization Standards

### Images
- **Format**: WebP (converted from PNG/JPG)
- **Quality**: 85% (good balance of quality/size)
- **Max dimensions**: 1920x1080px (maintains aspect ratio)
- **Compression**: Effort level 4/6

**Benefits**:
- ~30-40% smaller than PNG
- ~20-30% smaller than JPG
- Better quality at equivalent size
- Universal browser support

### Videos
- **Format**: MP4 (H.264)
- **Max dimensions**: 1280x720px
- **Video bitrate**: 1 Mbps
- **Audio bitrate**: 128 kbps
- **Codec**: H.264 (libx264) for video, AAC for audio

**Benefits**:
- Significantly reduced file sizes
- Fast streaming performance
- Maintains visual quality
- Broad compatibility

## 🔄 Content Updates

Media is automatically synced from Replicate's official models using the migration script located in the relevance-api-node repository:

```
apps/nodeapi/src/codegeneration/replicate/migrate-media-to-cdn.ts
```

### Running the Migration

```bash
# From relevance-api-node/apps/nodeapi
cd src/codegeneration/replicate

# Dry run to preview changes
pnpm exec tsx migrate-media-to-cdn.ts --dry-run

# Migrate a single collection for testing
pnpm exec tsx migrate-media-to-cdn.ts --collection remove-backgrounds

# Full migration
pnpm exec tsx migrate-media-to-cdn.ts

# Skip video optimization (faster, but larger files)
pnpm exec tsx migrate-media-to-cdn.ts --skip-video-optimization
```

### What the Script Does

1. **Discovers** all media URLs from collections.json and model files
2. **Downloads** media from Replicate's CDN (replicate.delivery)
3. **Optimizes**:
   - Images → WebP with compression
   - Videos → MP4 with reduced bitrate (optional)
4. **Organizes** files in the proper CDN structure
5. **Updates** JSON files to reference new CDN URLs

## 📊 Collections Overview

Currently includes 8 active collections:

| Collection | Slug | Models | Media Types |
|------------|------|--------|-------------|
| Generate videos | `text-to-video` | 73 | Images, Videos |
| Generate images | `text-to-image` | 66 | Images |
| Text to Speech | `text-to-speech` | 25 | Images |
| Speech to Text | `speech-to-text` | 13 | Images |
| AI Music Generation | `ai-music-generation` | 16 | Images, Audio |
| Lip Sync | `lipsync` | 13 | Images, Videos |
| Remove Backgrounds | `remove-backgrounds` | 14 | Images |
| Video to Text | `video-to-text` | 12 | Images, Videos |

## 🛠️ Maintenance

### Adding New Collections

1. Update `collections.json` with `"included": true`
2. Ensure collection has `models.json` with media URLs
3. Run migration script
4. Commit new media to CDN repo
5. Deploy CDN changes

### Updating Existing Media

1. Update source URLs in JSON files
2. Delete old media files from CDN (if replacing)
3. Run migration script
4. Commit and deploy

### Monitoring

- **Storage usage**: Monitor `/replicate` folder size
- **Optimization rates**: Check migration script output for space saved
- **Missing media**: Watch for 404s on CDN URLs

## 📝 Related Documentation

- [Main CDN README](../README.md)
- [Replicate Collections Data](https://github.com/relevanceai/relevance-api-node/tree/development/apps/nodeapi/src/codegeneration/replicate)
- [Migration Script Source](https://github.com/relevanceai/relevance-api-node/blob/development/apps/nodeapi/src/codegeneration/replicate/migrate-media-to-cdn.ts)

## 🔒 Access & Permissions

Media in this directory is publicly accessible via CDN. Ensure:
- No sensitive/proprietary content
- All media is properly licensed
- Complies with Replicate's terms of use

---

**Last updated**: 2025-11-11
**Maintained by**: Engineering Team
