---
layout: post
title: building portable settings.py
excerpt_separator: <!--more-->
---

As I work with django projects, one of the most important things to me, is to make my projects as portable as possible. 
This usually starts with the django settings.py file, as it usually contain paths to templates, static and media folders.
 
 <!--more-->

The best way for me, is to build a function that would return the absolute path to my project base


{% highlight python %}
import os

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__),
                                        os.path.pardir))
# function base will return current absolute path
# the below function will return the project base as one step back from 
# where the settings.py is sitting
def base(f=''):
    return os.path.join(BASE_DIR, f)

# use case / with settings up django templates folder for instance 
# Template DIRS
TEMPLATE_DIRS = (
    base('templates/'),
)
{% endhighlight %}
     
     
Salam.