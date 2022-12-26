FROM redis:4.0.11
ENV REDIS_PASSWORD EJZKK7foRij2rxTA
CMD ["sh", "-c", "exec redis-server --requirepass \"$REDIS_PASSWORD\""]