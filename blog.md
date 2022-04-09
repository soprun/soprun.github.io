---
layout: default
permalink: /blog
title: Blog
---

<h1>Latest Posts:</h1>

<ul>
  {% for post in site.posts %}
    <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
