# List of overloaded files for specific needs in this repository

## Backport meetings order
- **app/controllers/decidim/meetings/meetings_controller.rb**

## Disable fast signup 
- **config/initializers/devise.rb**
Added:

```ruby
   # frozen_string_literal: true

   Devise.setup do |config|
     # Disable fast signup
     config.allow_unconfirmed_access_for = 0.days
   end
```

## Add birthday and postal code fields in registration form
 - **app/commands/decidim/create_registration.rb**
From https://github.com/decidim/decidim/blob/release/0.23-stable/decidim-core/app/commands/decidim/create_registration.rb
Added:
```ruby
    extended_data: {
      birthdate: form.birthdate,
      postal_code: form.postal_code
    }
```

 - **app/forms/decidim/registration_form.rb**
 From https://github.com/decidim/decidim/blob/release/0.23-stable/decidim-core/app/forms/decidim/registration_form.rb

 - **app/views/decidim/devise/registrations/new.html.erb**
From https://github.com/decidim/decidim/blob/release/0.23-stable/decidim-core/app/views/decidim/devise/registrations/new.html.erb

 - **config/locales/de.yml**
 - **config/locales/en.yml**
 - **config/locales/fr.yml**
 - **spec/commands/decidim/create_registration_spec.rb**
 - **spec/forms/registration_form_spec.rb**
 - **spec/system/authentication_spec.rb**
## Backport fix users_answers_serializer
**PR #11**
* `app/serializers/decidim/meetings/registration_serializer.rb`  
Fix meetings registration serializer
  
* `lib/decidim/forms/user_answers_serializer.rb`  
Fix UserAnswersSerializer for CSV exports
