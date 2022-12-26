from typing import Any
from django.db.models import QuerySet
from django.contrib import admin


class CategoryListFilter(admin.SimpleListFilter):
    title = "category"
    parameter_name = "category"

    def lookups(self, request: Any, model_admin: Any) -> list[tuple[Any, str]]:
        category_ids = model_admin.get_queryset(
            request=request
        ).values_list(
            "category_id", flat=True
        )
        lookups = []

        for category_id in category_ids:
            lookups.append(
                (
                    category_id, f"Category with id = {category_id}"
                )
            )

        return lookups

    def queryset(self, request: Any, queryset: QuerySet) -> QuerySet | None:
        value = self.value()
        if value:
            queryset = queryset.filter(category_id=value)
        return queryset