""" Core URL Configuration """
from django.urls import path
from sentiment_analysis.views import AnalysisDetailView


app_name = 'sentiment_analysis'
urlpatterns = [
    path('', AnalysisDetailView.as_view(), name='home'),
]
