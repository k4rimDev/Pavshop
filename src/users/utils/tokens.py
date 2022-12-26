from django.contrib.auth.tokens import PasswordResetTokenGenerator
import six

from django.contrib.auth import get_user_model

User = get_user_model()

class AccountActivationTokenGenerator(PasswordResetTokenGenerator):
    def _make_hash_value(self, user: User, timestamp: int):
        return (
            six.text_type(user.pk) + six.text_type(timestamp) +
            six.text_type(user.is_active)
        )


account_activation_token = AccountActivationTokenGenerator()