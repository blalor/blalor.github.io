---
title: Author Index
layout: page
excerpt: "An archive of posts sorted by author."
show_excerpts: false
---

{%- assign postsByAuthor = site.posts | group_by_exp: 'post', 'post.author | default: post.authors[0] | default: site.author' -%}

<ul class="taxonomy-index">
  {% for a in postsByAuthor %}
  {%- assign author = site.data.authors[a.name] | default: a.name -%}
    <li>
      <a href="#{{ author.name }}">
        <strong>{{ author.name }}</strong> <span class="taxonomy-count">{{ a.items | size }}</span>
      </a>
    </li>
  {% endfor %}
</ul>

{% for a in postsByAuthor %}
{%- assign author = site.data.authors[a.name] | default: a.name -%}
  <section id="{{ author.name }}" class="taxonomy-section">
    <h2 class="taxonomy-title">{{ author.name }}</h2>
    <div class="entries-{{ page.entries_layout | default: 'list' }}">
      {% for entry in a.items %}
        {% include entry.html %}
      {% endfor %}
    </div>
    <a href="#page-title" class="back-to-top">{{ site.data.text[site.locale].back_to_top | default: 'Back to Top' }} &uarr;</a>
  </section>
{% endfor %}
