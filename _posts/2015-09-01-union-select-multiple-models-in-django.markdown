---
layout: post
title: union select multiple models in django
excerpt_separator: <!--more-->
---

Django ORM helps in overcoming most of the typical SQL requirements, selecting, inserting,
updating and deleting. All works perfectly as long as you are performing within the ORM guidelines.
Sooner or later, your application logic tends to grow which will push you to write nested and complicated queries.

Django ORM provides some decent API to help you cope. Yet, in some of my projects,
I was faced with the challenge of hanlding similar models which in design should be seperated.
Yet, they need to be queried and viewed in one context.


<!--more-->

For this example, I will use a project that I've worked on recently which is a portal to host promotions and bargains,
they share some attribute but they are very different in logic and operation. With that, you need to build a
listing page to see a combination of both, some programmers try to combine the query using dict tools but for me,
the best approach is to use view based models.

 The idea is to convert the below model into a view to be queries and managed for select from one interface


{% highlight python %}

class Bargain(models.Model):
    DRAFT = 0
    PUBLISHED = 1
    DEFAULT_STATUS = PUBLISHED
    STATUSES = (
        (PUBLISHED, _('Published')),
        (DRAFT, _('Draft')),
    )

    headline = models.CharField(_('Headlines'), max_length=200, )
    slug = models.SlugField(null=True, blank=True, editable=False)
    price_before = models.DecimalField(help_text=_('The price before bargain and/or original price'),
                                       max_digits=8, decimal_places=3)
    price_after = models.DecimalField(help_text=_('New price or new bargain'),
                                      max_digits=8, decimal_places=3)
    status = models.PositiveIntegerField(choices=STATUSES, default=DEFAULT_STATUS)
    start_date = models.DateField(_('Start date'), )
    due_date = models.DateField(_('Due date'))
    description = HTMLField(_('Description'), null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    owner_ct = models.ForeignKey(ContentType, verbose_name='content type')
    owner_id = models.PositiveIntegerField('owner id')
    owner_object = generic.GenericForeignKey('owner_ct', 'owner_id')

    view_count = generic.GenericRelation(ViewCount)
    ratings = generic.GenericRelation(Rate)
    images = generic.GenericRelation(Image)

    def __unicode__(self):
        return u'%s' % self.headline


class Promotion(models.Model):
    DRAFT = 0
    PUBLISHED = 1
    DEFAULT_STATUS = PUBLISHED
    STATUSES = (
        (PUBLISHED, _('Published')),
        (DRAFT, _('Draft')),
    )

    headline = models.CharField(_('Headlines'), max_length=200, )
    slug = models.SlugField(null=True, blank=True, editable=False)
    highlight = models.CharField(_('Highlight'), max_length=100, help_text=_('Highlight label'))
    status = models.PositiveIntegerField(choices=STATUSES, default=DEFAULT_STATUS)
    start_date = models.DateField(_('Start date'), )
    due_date = models.DateField(_('Due date'))
    description = HTMLField(_('Description'), null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    owner_ct = models.ForeignKey(ContentType, verbose_name='content type')
    owner_id = models.PositiveIntegerField('owner id', db_index=True)
    owner_object = generic.GenericForeignKey('owner_ct', 'owner_id')

    view_count = generic.GenericRelation(ViewCount)
    ratings = generic.GenericRelation(Rate)
    images = generic.GenericRelation(Image)

    def __unicode__(self):
        return u'%s' % self.headline

{% endhighlight %}

The above two models have a lot of similarity, now we need to build a view which will be used to union the two models. In order to do that, you could create the view directly into yout database or you could build the view into an SQL file and use signals to make sure the view executes everytime you run syncdb (Will write an article later about custom SQL execution)

I wrote the below query which will union the two table and indicate from which table it was unioned to help in deterimining where this record from (bargain or promotion?)

{% highlight sql %}

CREATE OR REPLACE VIEW list_item as SELECT
	*, (
		SELECT
			COALESCE (SUM(rate), 0)
		FROM
			rank_rate
		WHERE
			object_id = x."id"
		AND content_type_id = x."ct_id"
	) AS "content_rank"
FROM
	(
		SELECT
			"b"."id",
			"b"."headline",
			"b"."headline_en",
			"b"."headline_ar",
			"b"."slug",
			"b"."price_before",
			"b"."price_after",
			NULL AS "highlight",
			NULL AS "highlight_en",
			NULL AS "highlight_ar",
			"b"."status",
			"b"."start_date",
			"b"."due_date",
			"b"."description",
			"b"."description_en",
			"b"."description_ar",
			"b"."owner_ct_id",
			"b"."owner_id",
			"b"."created_at",
			'bargain' AS "source",
			(
				SELECT
					ID
				FROM
					django_content_type
				WHERE
					model = 'bargain'
			) AS ct_id
		FROM
			bargain_bargain b
		UNION
			SELECT
				"p"."id",
				"p"."headline",
				"p"."headline_en",
				"p"."headline_ar",
				"p"."slug",
				NULL AS "price_before",
				NULL AS "price_after",
				"p"."highlight",
				"p"."highlight_en",
				"p"."highlight_ar",
				"p"."status",
				"p"."start_date",
				"p"."due_date",
				"p"."description",
				"p"."description_en",
				"p"."description_ar",
				"p"."owner_ct_id",
				"p"."owner_id",
				"p"."created_at",
				'promotion' AS "source",
				(
					SELECT
						ID
					FROM
						django_content_type
					WHERE
						model = 'promotion'
				) AS ct_id
			FROM
				promotion_promotion P
	) x;

{% endhighlight %}     

Once you have executed your view with all required attribute, now you work on mapping your attribute to a model in
django and make sure the model remains unmanaged so it won't execute for creation `Meta: managed=False`,
below is example of how my model in the end looked like

{% highlight python %}

class Item(models.Model):
    """ Item model based on view """

    DRAFT = 0
    PUBLISHED = 1
    DEFAULT_STATUS = PUBLISHED
    STATUSES = (
        (PUBLISHED, _('Published')),
        (DRAFT, _('Draft')),
    )

    headline = models.CharField(_('Headlines'), max_length=200, )
    slug = models.SlugField(null=True, blank=True, editable=False)
    price_before = models.DecimalField(help_text=_('The price before and/or original price'),
                                       max_digits=8, decimal_places=3)
    price_after = models.DecimalField(help_text=_('New price or new bargain'),
                                      max_digits=8, decimal_places=3)
    highlight = models.CharField(_('Highlight'), max_length=100, help_text=_('Highlight label'))
    status = models.PositiveIntegerField(choices=STATUSES, default=DEFAULT_STATUS)
    start_date = models.DateField(_('Start date'), )
    due_date = models.DateField(_('Due date'))
    description = HTMLField(_('Description'), null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    owner_ct = models.ForeignKey(ContentType, verbose_name='content type')
    owner_id = models.PositiveIntegerField('owner id')
    owner_object = generic.GenericForeignKey('owner_ct', 'owner_id')

    source = models.CharField(max_length=100, )
    content_rank = models.IntegerField(max_length=100, )

    class Meta:
        managed = False # this will prevent table from executing when running syncdb
        db_table = 'list_item'

    def __unicode__(self):
        return u'%s - %s' % (self.source, self.id)   

{% endhighlight %}          

Now the benefit of using view based model than joining queryset together is tremedous when you have performance concerns. Its easier to tune your view to the optimum performance, it also works well with pagination and ordering. When joining two queryset together, you run the risk of iterating over all your queryset to fix the ordering and eventually paginate a list, while with the view set, these will happen directly in the SQL engine. If you have any comments or questions do not hesitate to ask.



Salam.
