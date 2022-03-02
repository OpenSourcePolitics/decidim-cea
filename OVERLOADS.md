# List of overloaded files for specific needs in this repository

## Reorder meetings indexes
- **app/controllers/decidim/meetings/meetings_controller.rb**
- **app/controllers/decidim/meetings/directory/meetings_controller.rb**
```ruby
def meetings
 @meetings ||= paginate(search.results.order(start_time: params.dig("filter", "date")&.include?("past") ? :desc : :asc))
end
```

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
* `app/models/decidim/proposals/proposal.rb`
c83e979 - Fix geocoding and permissions, 2022-03-02

* `app/jobs/decidim/machine_translation_resource_job.rb`
3a60bb9 - Add logs on Deepl translation (#13), 2021-11-09

* `app/controllers/decidim/proposals/proposals_controller.rb`
81dcc75 - Fix rubocop offenses, 2022-03-02

* `app/views/layouts/decidim/_head.html.erb`
855706e - Add integrity and defer to assets (#14), 2021-11-23

* `app/helpers/decidim/backup_helper.rb`
3485952 - add backup tasks + new job scheduling, 2021-11-08

* `app/services/deepl_translator.rb`
3a60bb9 - Add logs on Deepl translation (#13), 2021-11-09

* `app/services/decidim/s3_retention_service.rb`
e2a1493 - fix rubocop offenses, 2021-11-08

* `config/initializers/deepl.rb`
fb80871 - Fix application db initialization, 2021-11-03

* `lib/extends/commands/decidim/admin/create_participatory_space_private_user_extends.rb`
dc827d2 - add tests (#2), 2021-08-19

* `lib/extends/commands/decidim/admin/impersonate_user_extends.rb`
dc827d2 - add tests (#2), 2021-08-19

* `lib/decidim/participatory_processes/test/factories.rb`
3a91e96 - Add and fix broken factory, 2021-11-29

* `lib/helpers/decidim/dev/test/base_spec_helper.rb`
9fa517b - Linting files, 2021-11-03

