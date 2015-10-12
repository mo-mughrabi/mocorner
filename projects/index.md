---
layout: page
title: Projects
permalink: /projects/
---
##Web-based projects


I maintain in here a list of projects that I'm proud of, member of or owner in shares. Projects are
ordered by date or launch, each has a summary detail of my involvement and/or technology.

#paribus.co (*2015 - Lead developer*)

Paribus is a tool to help track price changes of purchases users make, it gets users money back on price drops.

#diwaniya labs (*2014 - Backend developer*)

I had the pleasure to work with diwaniyalab's team, during I was engaged in building and designing
a restFUL API to support their gaming platforms. The backend was developed using Django framework,
with <a target="_blank" href="http://django-rest-framework.org">django-rest-framework</a>.

My role was to entirely develop the backend from the ground up, along with handling authentications,
social authentications, managing sessions across API consumption via tokens. As well as building of
deployment cycle and automating scaling on amazon infrastructure.

#almenbr.com (*2013 - co-founder & lead developer*)

Almenbr is a platform for writing articles and discuss them with others around you in your
geographic location. t is a very effective tool to express your ideas to the biggest number
of readers. on the other hand, Almenbr will bring to you the ideas of other writers to you.

My role was to entirely develop the site from the ground up, the project was one of the longest
estimated at 4 man months of effort. Project uses Django as backend, at time of launching the
beta had 21,788 number of lines for the backend. Heavily relying on
<a target="_blank"href="http://django-rest-framework.org">django-rest-framework</a> for all Ajax operations.
Also worked on all javascript responsible to interact with backend via Ajax

#youraok.net (*2013 - lead developer*)

Youraok is a social networking site and portfolio manager specially designed to cater for architects and
    designers. Both as individual talents and firms running such businesses.

The site went into development using Django 1.4 and Bootstrap 2.3. What makes this project different
than others, we focused on scalable infrastructures by using Heroku and NewRelic to have in-depth
analysis of the site utilization.

#garage (*2013 - co-founder & developer*)


Garage is a trendy new website for trading vehicle, garage.com.kw was developed and designed completely
in Kuwait to serve the country as a start, Garage was developed in depth to cater for extreme and
complex scenarios for publishing vehicles.

Minimal interruptions and the best of a user experience. We've spent a fair amount of time in
understanding the current market trends and building a sustainable and suitable platform to match the
market needs.

During development, I worked with Django 1.4 and AngularJS, the web application is based on a large set
of restful web services which in we used heavy AngularJS operations to render into layout.

**Update:** The website was taken down due to unsuccessful launch, hence I'm putting the code out on
public repository, feel free to browse or fork if you have similar requirements <a
    href="https://github.com/mo-mughrabi/garage" target="_blank">here</a>.


#mazban.com (*2012 - founder & developer*)

mazban is an online community build from scratch using Django 1.3. The application is intended to serve
the middle east countries as a trading gateway, whereby users can post classifieds or events. The site
was launched on April 2012 for <a href="http://kw.mazban.com/">Kuwait</a>, <a
    href="http://qa.mazban.com/">Qatar</a> and <a href="http://bh.mazban.com/">Bahrain</a> as the first phase.

mazban architecture is designed on top of amazon cloud computing for scalability, using agile
development we are constantly patching the application code. also there is RabbitMQ for messaging and to
offload user requests, it also uses amazon S3 storage to push uploaded content.


##Libraries & tools


#[djsocial](https://github.com/mo-mughrabi/djsocial) - (*2014 - developer*)

Djsocial was developed as initiative to create a robotic web based solution for social media, starting
with twitter and expanding later to other channels. We will continue to support it if any issue arises
and we will work on a road map to build further features and integration with other social channels in
the next period.

Djsocial was built using django 1.6 and celery for managing tasks and timed jobs.

At the moment, Djsocial is built with twitter integration. With the following functionality

1. Auto follow certain hash tags
2. Auto favorite certain hash tags
3. Auto follow back
4. Auto un-follow back

#[docker-tomcat8](https://github.com/mo-mughrabi/docker-tomcat8) (*2014 - developer*)

The new docker containers are receiving a lot of attention from developers and investors alike. Dockers
are suppose to help in creating a unified configuration across a platform(s), whereby you can create a
Dockerfile that instruct the startup of your container with specific details of your add as well.

I think, my next contributions will be bunch of different dockers that developers can use for different
webapp projects. For now, this repository contains a dockerfile which will bootup a Tomcat6 with JRE
from Oracle.com.


#[python-linkedin](https://github.com/mo-mughrabi/python-linkedin) (*2012 - developer*)

I usually use linkedin to maintain my career history, recommendation and resume. When I decided to work
on mocorner.com, I was faced with creating a copy of my resume here too, this is when I decided to
integrate mocorner.com with linkedin to retrieve my resume and maintain synchronization process.
For the integration, one library existed linkedin-python by Özgür Vatansever. Unfortunately, the library
is not maintained since 2010 and it was missing a very important function (<i>at least for me</i>) which
is retrieving '<a href="https://developer.linkedin.com/comment/4323#comment-4323" target="_blank">recommendations-relieved</a>'.
This is when I deiced to fork it into github and work on adding this function. Now, the library
available in github with recommendation retrieval API.

Feel free to use it and if you have any issues you may report them <a href="https://github.com/mo-mughrabi/python-linkedin/issues">here</a>.

#[django-google-translator](https://github.com/mo-mughrabi/django-google-translator/) (*2012 - developer*)

This simple package is to use for running your .PO files for translation against google translation API.
The package will extend your django command interface with a new command to retrieve all your .PO files,
translate the strings and update the .PO file with its translation (remember, this utility will not
generate the .mo
files for you) it will place the translated strings inside the .PO file.

Feel free to use it and if you have any issues you may report them <a
    href="https://github.com/mo-mughrabi/django-google-translator/issues">here</a>.

#[django-dba](http://mo-mughrabi.github.com/django-dba/) (*2012 - developer*)

django-dba focuses on creating an interface for developers working with django applications. It is
intended to ease maintaining
and administering your database, for common dba operations such as viewing tables status, re-initiating
database (drop & create),
viewing table storage, viewing collation setup, comparing physical tables with django app models.

Feel free to use it and if you have any issues you may report them <a
    href="https://github.com/mo-mughrabi/django-dba/issues">here</a>.
