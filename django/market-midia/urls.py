"""core_proj URL Configuration."""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth.views import LogoutView
from django.urls import include, path



urlpatterns = [
    path('admin/', admin.site.urls),
]

if settings.DEBUG:
    # Getting media files for debug environment.
    urlpatterns = static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) + urlpatterns


