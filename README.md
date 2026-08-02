# Portfolio — Edwin Franck B. Kouassi

Site personnel une page, en bento. Chaque tuile s'ouvre en page-dans-la-page (étude de cas).
Statique, sans build, sans dépendance externe : **HTML + CSS + un fichier GSAP local**.

**Thèse :** *Je dessine, je code, je livre — et je forme ceux qui prendront la suite.*

---

## Contenu

| Tuile | Page |
|---|---|
| Moi | qui je suis, la chaîne complète, contact |
| Ce que je fais | design · développement · architecture · pédagogie |
| Le design | 15 créations graphiques + Behance |
| Zeno | plateforme de gestion d'école, 530+ utilisateurs, 2 campus en production |
| Djai | app mobile Mobile Money, 100 % locale |
| Devkora | SaaS multi-tenant d'évaluation de code |
| Entourage Africa | plateforme d'experts africains — +100 experts, 35 pays (client) |
| Solve | plateforme communautaire de développeurs — 54 tests, Supabase |
| Homies | party game multijoueur temps réel |
| Lumio | SaaS PWA paroissial + Mobile Money |
| Epitech | étudiant → responsable du Bachelor → Hub d'Innovation |
| Clients | Entourage, UNICEF, Echopen, ADCVI, MTN… |
| Stack | ce que j'utilise réellement en production |
| Parcours | de Paint à 7 ans au Hub d'Innovation |
| Contact | ce que je peux faire, comment me joindre |

## Utilisation

Ouvrir `index.html`. Aucun serveur nécessaire.

- `?theme=light` ou la touche **L** — bascule clair / sombre (mémorisé)
- `?static=1` — coupe les animations (impression, export PDF, captures)
- `#zeno`, `#djai`, `#contact`… — ouvre directement une carte
- **Échap** ferme · **← →** passe d'une carte à l'autre

## Déploiement — GitHub Pages

```bash
cd portfolio
git init && git add -A && git commit -m "Portfolio"
git branch -M main
git remote add origin git@github.com:edwinfranck/edwinfranck.github.io.git
git push -u origin main
```

Le dépôt doit s'appeler **`edwinfranck.github.io`** pour être servi à la racine du domaine.
Ensuite : *Settings → Pages → Source : `main` / `(root)`*. En ligne sur `https://edwinfranck.github.io` en une minute.

Le fichier `.nojekyll` empêche GitHub de faire passer le site dans Jekyll (inutile ici et source d'ennuis).

### Domaine personnalisé (devpanl.dev)

1. Ajouter un fichier `CNAME` à la racine contenant `edwin.devpanl.dev`
2. Chez le registrar, créer un enregistrement `CNAME` : `edwin` → `edwinfranck.github.io`
3. *Settings → Pages → Custom domain*, puis cocher **Enforce HTTPS**

## Structure

```
portfolio/
├── index.html              tout le site (contenu + styles + logique)
├── .nojekyll
└── assets/
    ├── pdf/                CV (compressé, 290 Ko)
    ├── css/fonts.css       @font-face Anton + IBM Plex
    ├── fonts/*.woff2       polices vendues (aucun appel externe)
    ├── js/gsap.min.js      animations
    └── img/
        ├── edwin.jpg       portrait
        ├── og.jpg          image de partage (LinkedIn, WhatsApp…)
        ├── zeno.jpg            capture réelle de zeno.epitools.bj
        ├── devkora.webp        page d'accueil Devkora (mockup MacBook)
        ├── solve.webp          page d'accueil Solve (mockup MacBook)
        ├── entourage.webp      annuaire d'experts Entourage (mockup MacBook)
        ├── homies-mobile.webp  Homies sur mobile (mockup Galaxy)
        ├── djai.jpg            page de présentation de l'application
        └── design/*.webp       15 créations graphiques
```

Poids total : ~2,6 Mo (dont 860 Ko de créations graphiques et 290 Ko de CV). Aucune requête vers un CDN, aucun traceur.

## À compléter

Les captures manquantes — c'est ce qui renforcera le plus le site :

- [ ] **Lumio** — un écran de don Mobile Money (seul projet encore sans capture)
- [ ] **ADCVI** — le site est en ligne sur adcvi.ci mais son contenu se charge au défilement : la capture automatique revient vide. Une capture manuelle ferait l'affaire.
- [ ] **Zeno** — une vue de l'application connectée (aujourd'hui c'est la page publique)

Pour en ajouter une : déposer l'image dans `assets/img/`, puis dans la page concernée
remplacer le bloc `<p class="cap">… capture à venir …</p>` par
`<div class="shot rv"><img src="assets/img/xxx.jpg" alt="…"></div>`.
