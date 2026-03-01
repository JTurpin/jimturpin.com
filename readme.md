# jimturpin.com

Personal CV/resume website for Jim Turpin, built with [Hugo](https://gohugo.io/) and the [Almeida CV](https://github.com/ineesalmeida/almeida-cv) theme.

Live site: **https://jimturpin.com/**

## Tech Stack

- **Hugo** - Static site generator
- **Almeida CV theme** - Printable, responsive CV layout
- **GitHub Pages** - Hosting (deployed via GitHub Actions on push to `main`)
- **Podman** - Multi-arch container builds (amd64/arm64)
- **static-web-server** - Minimal container runtime (`FROM scratch`, no OS-level dependencies)

## Project Structure

```
├── config.toml          # Hugo site configuration
├── data/
│   └── content.yaml     # All CV content (experience, education, skills, etc.)
├── static/img/          # Avatar and favicon
├── themes/almeida-cv/   # CV theme (git submodule)
├── Dockerfile           # Multi-stage build: Hugo → scratch + static-web-server
├── publish.sh           # Build and push multi-arch container images
└── .github/workflows/
    └── hugo-deploy.yml  # GitHub Actions deployment to Pages
```

## Editing Content

All CV content lives in `data/content.yaml`. Update that file to change experience, education, skills, or profile info.

## Local Development

```bash
hugo server -D
```

Then open http://localhost:1313.

## Container Build

The Dockerfile produces a minimal `FROM scratch` image (~8 MB) containing only the static-web-server binary and the generated HTML. No OS packages, no vulnerability surface.

```bash
# Build and push multi-arch images to Docker Hub
./publish.sh
```

Or build locally for testing:

```bash
podman build -t jimturpin.com .
podman run -p 8080:80 jimturpin.com
```

## Deployment

Pushes to `main` automatically deploy to GitHub Pages via the workflow in `.github/workflows/hugo-deploy.yml`.

## License

Theme is MIT licensed. Site content is personal and not licensed for reuse.
