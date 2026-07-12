# 🤝 Guía de Contribución — morty_app

Documento que describe cómo contribuir al proyecto: branching, commits, PRs y código.

## 🌳 Estrategia de branching

Usamos **feature-based branching** con prefijos convencionales:

### Ramas principales

| Rama | Propósito | Protegida |
|------|-----------|----------|
| `main` | Producción (tagged releases) | ✅ Sí |
| `dev` | Integración (rama base para features) | ✅ Sí |

### Ramas de trabajo

**Convención**: `<tipo>/<descripcion-corta>`

```
feat/add-character-filtering      → Nueva característica
fix/character-image-animation      → Bug fix
test/improve-character-test        → Cambios en tests
refac/extract-character-widgets    → Refactorización
doc/improve-contributing           → Documentación
chore/update-dependencies          → Mantenimiento
```

**Proceso**:

```bash
# 1. Crear rama desde `dev` (siempre)
git checkout dev
git pull origin dev
git checkout -b feat/my-feature

# 2. Trabajar commits pequeños (ver abajo)
# ... edits ...
git add .
git commit -m "feat: add episode filtering"

# 3. Push y crear PR
git push origin feat/my-feature
# → Abrir PR en GitHub hacia `dev`
```



**Last updated**: Julio 2026  
**Maintainer**: Manuel Ruelas
