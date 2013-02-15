#CSCE 431-502 Group H Origin Repository

This project is an online bulleting board system for Texas A&amp;M University.

Before cloning this project, set up your Ruby environment with Ruby 1.9.3. After
cloning, run 'bundle install' to install the gems specified in the Gemfile. Any
collaborator who adds a gem to the Gemfile should notify the others to rerun
this command.

The project is laid out in a similar fashion to the 'Rails Tutorial' project.
Unit and integration tests are written with RSpec and can be found in the spec
directory. JavaScript, CSS, and images should be located in app/assets.
Controllers, models, and views are each located in their own folder within app.
Static pages are served from public (should generally be avoided).

The database may be administered using rake db: commands. See rake -T for
details. The important thing is to run rake db:reset when the database may have
changed, and rake db:test:prepare after any reset.

Tests, both unit and integration, may be run using the RSpec utility (included
in the Gemfile). All tests are located within the spec directory. All
contributors should ensure that all tests are green before pushing to origin.
