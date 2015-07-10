---
layout: page
title: Author Index
excerpt: "An archive of posts sorted by author."
search_omit: true
---

{% assign posts_by_author = site.posts | group_by:"author" %}

<ul class="tag-box inline">
  {% for item in posts_by_author %}
    {% assign author_id = item.name %}
    {% assign posts = item.items %}

    {% if site.data.authors[author_id] %}
      {% if site.data.authors[author_id].is_owner != true %}
        {% assign author = site.data.authors[author_id] %}
      {% else %}
        {% assign author = site.owner %}
      {% endif %}

      <li><a href="#{{ author_id | slugify }}">{{ author.name }} <span>{{ posts.size }}</span></a></li>
    {% endif %}
  {% endfor %}
</ul>

{% for item in posts_by_author %}
  {% assign author_id = item.name %}
  {% assign posts = item.items %}
  {% if site.data.authors[author_id] %}
    {% if site.data.authors[author_id].is_owner != true %}
      {% assign author = site.data.authors[author_id] %}
    {% else %}
      {% assign author = site.owner %}
    {% endif %}
  <h2 id="{{ author_id | slugify}}">{{ author.name }}</h2>
  <ul class="post-list">
    {% for post in posts %}{% if post.title != null %}
    <li><a href="{{ site.url }}{{ post.url }}">{{ post.title }}<span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></li>
    {% endif %}{% endfor %}
  </ul>
  {% endif %}
{% endfor %}
