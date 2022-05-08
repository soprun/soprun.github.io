---
layout: post
permalink: /paragraphs
title: 'Basic writing and formatting syntax'
categories: [paragraph, markdown]
tags: [test, tag, tags, two]
thumbnail: 'https://images.unsplash.com/photo-1563206767-5b18f218e8de'
thumbnail_cover: 'https://images.unsplash.com/photo-1563206767-5b18f218e8de?w=1300&h=300&fit=crop'
---

# Header 1

Paragraphs are separated by a blank line.

2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists look like:

* this one
* that one
* the other one

Lorem ipsum dolor sit amet, consectetur adipisicing elit. A ad amet atque autem doloribus dolorum ex facere in itaque
maiores minima numquam pariatur quaerat quam quia ut, vitae. Et, nesciunt.

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Adipisci corporis facilis iure perspiciatis. Debitis esse est
excepturi labore laboriosam repellendus voluptatum! Consequuntur eos ex laborum molestias quisquam rem rerum voluptas!

## Header 2

> This is a blockquote following a header.
>
> When something is important enough, you do it even if the odds are not in your favor.

### Header 3

javascript:

```javascript
// Javascript code with syntax highlighting.
var fun = function lang(l) {
  dateformat.i18n = require('./lang/' + l)
  return true;
}
```

ruby:

{% highlight ruby %}
# Ruby code with syntax highlighting
GitHubPages::Dependencies.gems.each do |gem, version|
s.add_dependency(gem, "= #{version}")
end
{% endhighlight %}

php:

```php
<?php
  	$date = '05/05/2021';
	echo DateTime::createFromFormat("d/m/Y", $date)->format('Y-m-d');
	//2021-05-05
```

go:

```go
package main

import (
  "fmt"
)

func main() {
  fmt.Println(`
  Golang is a statically typed language loved
  by scientists and researchers, developed by
  Google.`)
}
```

#### Header 4

* This is an unordered list following a header.
* This is an unordered list following a header.
* This is an unordered list following a header.

##### Header 5

1. This is an ordered list following a header.
2. This is an ordered list following a header.
3. This is an ordered list following a header.

###### Header 6

| head1        | head two          | three |
|:-------------|:------------------|:------|
| ok           | good swedish fish | nice  |
| out of stock | good and plenty   | nice  |
| ok           | good `oreos`      | hmm   |
| ok           | good `zoute` drop | yumm  |

### There's a horizontal rule below this.

* * *

### Here is an unordered list:

* Item foo
* Item bar
* Item baz
* Item zip

### And an ordered list:

1. Item one
1. Item two
1. Item three
1. Item four

### And a nested list:

- level 1 item
  - level 2 item
  - level 2 item
    - level 3 item
    - level 3 item
- level 1 item
  - level 2 item
  - level 2 item
  - level 2 item
- level 1 item
  - level 2 item
  - level 2 item
- level 1 item

### Small image

![Octocat](https://github.githubassets.com/images/icons/emoji/octocat.png)

### Large image

![Branching](https://guides.github.com/activities/hello-world/branching.png)

### Definition lists can be used with HTML syntax.

<dl>
<dt>Name</dt>
<dd>Godzilla</dd>
<dt>Born</dt>
<dd>1952</dd>
<dt>Birthplace</dt>
<dd>Japan</dd>
<dt>Color</dt>
<dd>Green</dd>
</dl>
