---
title: Acceuil
layout: hextra-home
---

{{< hextra/hero-badge >}}
  <div class="hx:w-2 hx:h-2 hx:rounded-full hx:bg-warning-400"></div>
  <span>Dernière mise à jour du site le : 08/11/2026</span>
  {{< icon name="code" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-headline >}}
  Baptiste CROUVIZIER
{{< /hextra/hero-headline >}}
</div>

<div class="hx:mb-6">
{{< hextra/hero-subtitle >}}
  Étudiant en BTS CIEL au Lycée International&nbsp;<br class="hx:sm:block hx:hidden" />Victor Hugo de Colomiers
{{< /hextra/hero-subtitle >}}
</div>

{{< hextra/feature-grid cols="2" >}}
{{< cards cols="2" >}}
  {{< card link="CV.pdf" title="Mon CV" icon="academic-cap" >}}
  {{< card link="about" title="À propos" icon="question-mark-circle" >}}
{{< /cards >}}
{{< /hextra/feature-grid >}}  

<div class="hx:mb-6"></div>

<div class="hx:mb-6">
{{< hextra/hero-subtitle >}}
  Les tutoriels :
{{< /hextra/hero-subtitle >}}
</div>

{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    icon="desktop-computer"
    link="administration-systeme"
    title="Administration système"
    subtitle="Création de supports USB bootables, automatisation de l’installation de logiciels et configuration de Windows 10/11."
  >}}

  {{< hextra/feature-card
    icon="terminal"
    link="linux/debian"
    title="Debian"
    subtitle="Configuration de base (IP, SSH, Dépots de mise à jour etc..), installation et configuration de divers services tel que isc-dhcp, wireguard, FOG etc..."
  >}}

{{< /hextra/feature-grid >}}
