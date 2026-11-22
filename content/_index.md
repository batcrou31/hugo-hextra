---
title: Acceuil
layout: hextra-home
---

{{< hextra/hero-badge >}}
  <div class="hx:w-2 hx:h-2 hx:rounded-full hx:bg-primary-400"></div>
  <span>Dernière mise à jour du site le : {{< lastmod >}} </span>
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
  {{< card link="cv_crouvizier_baptiste_12-11-2026.pdf" title="Mon CV" icon="academic-cap" >}}
  {{< card link="about" title="À propos" icon="question-mark-circle" >}}
{{< /cards >}}
{{< /hextra/feature-grid >}}  

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-subtitle >}}
  Mes derniers Tutoriels :
{{< /hextra/hero-subtitle >}}
</div>

{{< hextra/feature-grid cols="1" >}}
{{< cards cols="3" >}}
  {{< card link="virtualisation/hyperv/install-vm" title="Création d'une machine virtuelle sur Hyper-V" image="/images/virtualisation/cover-hyperv-install-vm.png" imageStyle="object-fit:cover; aspect-ratio:16/9;" tag="22/11/2026" tagColor="blue" tagIcon="upload" >}}
  {{< card link="docker/compose/guacamole" title="Instalattion et configuration d'Apache Guacamole avec une base de donnée MySQL" image="/images/compose/cover-guacamole.png" imageStyle="object-fit:cover; aspect-ratio:16/9;" tag="20/11/2026" tagColor="blue" tagIcon="upload" >}}
  {{< card link="linux/debian/tiger_vnc" title="Instalattion et configuration de TigerVNC sur un environnement de bureau Xfce" image="/images/debian/cover-vnc-xfce.png" imageStyle="object-fit:cover; aspect-ratio:16/9;" tag="29/10/2026" tagColor="blue" tagIcon="upload" >}}
{{< /cards >}}
{{< /hextra/feature-grid >}}  