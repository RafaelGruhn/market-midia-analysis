"""Sentiment Analysis Views"""
from django.views.generic import View


class AnalysisDetailView(View):
    """Analysis Detail View"""

    def analysis(self):
        pass

    def get(self, request, *args, **kwargs):
        self.analysis()
        return super().get(*args, **kwargs)
