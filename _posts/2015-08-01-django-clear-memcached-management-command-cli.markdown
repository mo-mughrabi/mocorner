---
layout: post
title: django clear memcached management command (CLI)
excerpt_separator: <!--more-->
---

Often I use memcached in most production environment, but sooner or later you push changes and you cannot 
wait for the cache to timeout to see your changes. For that, I always attach a management command to 
my project which flushes memcached 

<!--more-->

{% highlight python %}
# -*- coding: utf-8 -*-
from django.core.management.base import BaseCommand, CommandError
from django.core.cache import cache


class Command(BaseCommand):
    args = ''
    help = 'Clear memcached'

    def handle(self, *args, **options):
        try:
            cache._cache.flush_all()
        except Exception as e:
            raise e
 {% endhighlight %}     