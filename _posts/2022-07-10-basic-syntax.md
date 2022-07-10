---
permalink: /basic-syntax
title: Basic syntax
published: false
---

# Headings

# Heading level 1

## Heading level 2

### Heading level 3

#### Heading level 4

##### Heading level 5

###### Heading level 6

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Emphasis: bold and italic

This is **bold** and this is _italic_.

This is ***bold and italic***.

---

# Code

At the command prompt, type `nano`.

``Use `code` in your Markdown file.``

```shell
docker rm $(docker ps -a -q)

docker container list -qa | xargs docker container stop && docker container prune

echo 123

command -v git
```


```javascript
<link rel="stylesheet" href="https://unpkg.com/@highlightjs/cdn-assets@11.5.1/styles/default.min.css">
<script type="module">
import hljs from 'https://unpkg.com/@highlightjs/cdn-assets@11.5.1/es/highlight.min.js';
//  and it's easy to individually load & register additional languages
import go from 'https://unpkg.com/@highlightjs/cdn-assets@11.5.1/es/languages/go.min.js';
hljs.registerLanguage('go', go);
</script>
```

```sql
CREATE TABLE "topic" (
    "id" integer NOT NULL PRIMARY KEY,
    "forum_id" integer NOT NULL,
    "subject" varchar(255) NOT NULL
);
ALTER TABLE "topic"
ADD CONSTRAINT forum_id FOREIGN KEY ("forum_id")
REFERENCES "forum" ("id");

-- Initials
insert into "topic" ("forum_id", "subject")
values (2, 'D''artagnian');
```

---

# images

```liquid

{ include image.liquid file="/assets/images/san-juan-mountains.jpg" alt="The San Juan Mountains are beautiful!" title="San Juan Mountains" lazy="yes"}
```


![Nathan Anderson](https://images.unsplash.com/photo-1478155536073-c815e5cefe44?auto=format&fit=crop&w=400&q=80 "Nathan Anderson")

[![Photo by Aditya Vyas](https://images.unsplash.com/photo-1657311277146-7ea9e88a3701?auto=format&fit=crop&w=400&q=80 "Photo by Aditya Vyas")](https://unsplash.com/photos/aN71p3mLj-A)




---

# Italic

- Italicized text is the *cat's meow*.
- Italicized text is the _cat's meow_.
- A*cat*meow


**Unordered list**

* Item 1
* Item 2
* Item 3
    * Item 3a
    * Item 3b
    * Item 3c

**Ordered list**

1. Step 1
2. Step 2
3. Step 3
    1. Step 3.1
    2. Step 3.2
    3. Step 3.3

**List in list**

1. Step 1
2. Step 2
3. Step 3
    * Item 3a
    * Item 3b
    * Item 3c

**Tasks list**

- [ ] This is the first list item.
- [ ] Here's the second list item.
- [ ] And here's the third list item.

- [x] This is the first list item.
- [x] Here's the second list item.
- [ ] And here's the third list item.

---

# Horizontal rules

***

---

_________________

---

# Emphasis

- This text is ***really important***.
- This text is ___really important___.
- This text is __*really important*__.
- This text is **_really important_**.
- This is really***very***important text.
- This is really ::very:: important text.

---

# PlantUML

You can use [PlantUML](http://plantuml.com/) in Markdown blocks. For example:

```plantuml
!define ICONURL https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/v2.1.0
skinparam defaultTextAlignment center
!include ICONURL/common.puml
!include ICONURL/font-awesome-5/gitlab.puml
!include ICONURL/font-awesome-5/java.puml
!include ICONURL/font-awesome-5/rocket.puml
!include ICONURL/font-awesome/newspaper_o.puml
FA_NEWSPAPER_O(news,good news!,node) #White {
FA5_GITLAB(gitlab,GitLab.com,node) #White
FA5_JAVA(java,PlantUML,node) #White
FA5_ROCKET(rocket,Integrated,node) #White
}
gitlab ..> java
java ..> rocket
```

---

https://docs.gitlab.com/ee/user/markdown.html#mermaid

```mermaid
graph TD;
  A-->B;
  A-->C;
  B-->D;
  C-->D;
```
