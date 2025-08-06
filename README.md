# 🛠️ Stacksmith

**Stacksmith** is a modular environment for launching local development stacks using Docker templates.

---

## 📦 Features

- 🔧 **Reusable templates** for common tech stacks (PHP + MySQL, Node.js + Next.js, WordPress, etc.)
- 🚀 **One-liner project bootstrapping** via `new-project.sh`
- 🧪 Separate folders for:
  - `playground/`: small throwaway/testing projects
  - `projects/`: full-featured big projects
- 🐳 docker-compose based

---

## 📁 Structure

```
/dev
├── new-project.sh          # CLI tool to generate a new project
├── README.md               # You are here :)
├── /templates              # Reusable stack blueprints
│   ├── next-php-mysql/
│   │   ├── docker-compose.yaml
│   │   ├── .env
│   │   └── meta.yaml
│   └── nodejs-next/
│       └── ...
├── /playground             # Monorepo for small local projects (Git-ignored)
│   └── .gitkeep
└── /projects               # Separate Git repositories for big projects (Git-ignored)
    └── .gitkeep
```

