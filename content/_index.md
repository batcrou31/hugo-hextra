---
title: Acceuil
layout: hextra-home
---

{{< hextra/hero-badge >}}
  <div class="hx:w-2 hx:h-2 hx:rounded-full hx:bg-primary-400"></div>
  <span>Dernière mise à jour du site le : 08/11/2026.</span>
{{< /hextra/hero-badge >}}

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-headline >}}
  Tuto informatique créé par&nbsp;<br class="hx:sm:block hx:hidden" />Baptiste CROUVIZIER
{{< /hextra/hero-headline >}}
</div>

<div class="hx:mb-12">
{{< hextra/hero-subtitle >}}
  Étudiant en BTS CIEL au Lycée International&nbsp;<br class="hx:sm:block hx:hidden" />Victor Hugo de Colomiers
{{< /hextra/hero-subtitle >}}
</div>

<!-- <div class="hx:mb-6">
{{< hextra/hero-button text="Mon CV" link="CV.pdf" >}}
</div>

<div class="hx:mb-6">
{{< hextra/hero-button text="À propos" link="CV.pdf" >}}
</div> -->

{{< cards cols="2" >}}
  {{< card link="CV.pdf" title="Mon CV" icon="academic-cap" >}}
  {{< card link="about" title="À propos" icon="question-mark-circle" >}}
{{< /cards >}}

<div class="hx:mt-6"></div>

{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    title="Lightweight as a Feather"
    subtitle="No dependency or Node.js is needed to use Hextra. Powered by Hugo, one of *the fastest* static site generators, building your site in just seconds with a single binary."
  >}}
  {{< hextra/feature-card
    title="Responsive with Dark Mode Included"
    subtitle="Looks great on different screen sizes. Built-in dark mode support, with auto-switching based on user's system preference."
  >}}
  {{< hextra/feature-card
    title="Build and Host for Free"
    subtitle="Build with GitHub Actions, and host for free on GitHub Pages. Alternatively it can be hosted on any static hosting service."
  >}}
  {{< hextra/feature-card
    title="Multi-Language Made Easy"
    subtitle="Create multi-language pages by just adding locales suffix to the Markdown file. Adding i18n support to your site is intuitive."
  >}}
  {{< hextra/feature-card
    title="And Much More..."
    icon="sparkles"
    subtitle="Syntax highlighting / Table of contents / SEO / RSS / LaTeX / Mermaid / Customizable / and more..."
  >}}
{{< /hextra/feature-grid >}}
