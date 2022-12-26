from __future__ import absolute_import, unicode_literals
import os
import logging
from celery import Celery
from celery.schedules import crontab

from django.conf import settings


logger = logging.getLogger("Celery")
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'pavshop.settings')
app = Celery('pavshop')
app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)

import os

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD')


app.conf.beat_schedule = {
    'every-day': {
        'task': 'users.tasks.send_email_user_not_logged_in_for_30_days',
        'schedule': crontab(minute=0, hour='*/24'),
    },
    'every-monday': {
        'task': 'users.tasks.setup_periodic_tasks',
        'schedule': crontab(hour=12, minute=10, day_of_week=1),
    },
}

if not settings.DEBUG:
    app.conf.update(
        BROKER_URL='redis://:{password}@redis:6379/0'.format(password=os.environ.get("REDIS_PASSWORD")),
        # CELERYBEAT_SCHEDULER='django_celery_beat.schedulers:DatabaseScheduler',
        CELERY_RESULT_BACKEND='redis://:{password}@redis:6379/1'.format(password=os.environ.get("REDIS_PASSWORD")),
        CELERY_DISABLE_RATE_LIMITS=True,
        CELERY_ACCEPT_CONTENT=['json', ],
        CELERY_TASK_SERIALIZER='json',
        CELERY_RESULT_SERIALIZER='json',
    )
else:
    app.conf.update(
        BROKER_URL='redis://:{password}@localhost:6379/0'.format(password="EJZKK7foRij2rxTA"),
        # CELERYBEAT_SCHEDULER='django_celery_beat.schedulers:DatabaseScheduler',
        CELERY_RESULT_BACKEND='redis://:{password}@localhost:6379/1'.format(password="EJZKK7foRij2rxTA"),
        CELERY_DISABLE_RATE_LIMITS=True,
        CELERY_ACCEPT_CONTENT=['json', ],
        CELERY_TASK_SERIALIZER='json',
        CELERY_RESULT_SERIALIZER='json',
    )
