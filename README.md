# ocpm

It, um.. manages package repos.

## Mirrors

Mirrors are how OCMP helps you create Upstreams from common sources, such as your OS vendor.

## Upstreams

These are sources of packages. Examples might be "centos-5.6", "ubuntu-10.04", or even "mycorp".

These might be just directories of packages, or they might be mirrors of upstream package repositories.

## Packages

A package from an upstream can come from many formats. We track the following meta-data:

  * name
  * version
  * iteration
  * architecture
  * maintainer
  * url
  * description
  * upstream (the "source" of the package)
  * dependencies

(Thanks to fpm!)

When ocpm imports a package, it will take it from it's existing path and do the following:

  * Update the metadata
  * Import the package to /srv/ocpm/packages/UPSTREAM/NAME

## Repositories

You can create as many repositories as you want. Repositories have a format (yum, apt, pacman, etc.), and they are
driven by a policy. Each repository allows you to have many packages inside of it. 

## Updating a Repository

Repositories can have packages added/removed/synchronized (where sync is tracking the latest version of a package).

At any given time, a repository can be "promoted", and it's policy will override another repository.

## Contributing to ocpm
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011, 2012 Opscode, Inc.. See LICENSE for details.

