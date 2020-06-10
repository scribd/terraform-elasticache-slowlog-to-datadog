# [1.5.0-alpha.1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.4.1...v1.5.0-alpha.1) (2020-06-10)


### Features

* update slowlog_check to v1.3.0-alpha.1 ([f361b84](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/f361b84817d26ca9c5e2e63dad916852890b59af))

## [1.4.1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.4.0...v1.4.1) (2020-05-08)


### Bug Fixes

* apply correct zip distribution of slowlog_check ([67c6c95](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/67c6c954e933bfce4a20262e81526fcc051e916e))

# [1.4.0](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.3.1...v1.4.0) (2020-05-05)


### Features

* use slowlog_check v1.1.0 ([0556462](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/05564624a3fa994f09831000fe574185f56e193a))

## [1.3.1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.3.0...v1.3.1) (2020-04-30)


### Bug Fixes

* no more LFS of the release zip ([e82dd38](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/e82dd380ae269690e448285beb6f5b7c50607a5f))
* stop tracking zip through git lfs, due to compatibility concerns ([0bd7713](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/0bd7713ee8fa4db98081312eaa37b354770d1962))


### Reverts

* Revert "chore(release): 1.3.0-alpha.1 [skip ci]" ([48aff63](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/48aff6324d436b93ffa707f34a85c38dc2559372))

# [1.3.0](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.2.1...v1.3.0) (2020-04-30)


### Bug Fixes

* give up on using null_resource to save on shipping a binary ([8144204](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/814420446e1bad24edc00867659550b0e3a98370))


### Features

* enable multiple invocations of the module in a single account ([9a7a764](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/9a7a7648c3929e3e3a9f0c06a6f0b03cd644eca8))

## [1.2.1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.2.0...v1.2.1) (2020-04-29)


### Bug Fixes

* correct dependency on null_resource ([2f30ccb](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/2f30ccb0103060b6d4af7a8de9c9479a2539750b))

# [1.2.0](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.1.0...v1.2.0) (2020-04-29)


### Features

* Use v1.0.1 of elasticache-slowlog-to-datadog ([a3195a1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/a3195a143daaf569c1a93309d1ab44e19ae2fc87))

# [1.1.0](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.0.2...v1.1.0) (2020-04-29)


### Features

* fire every minute ([dbda772](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/dbda772fd5c8fa5f2563528468c595b792d78348))

## [1.0.2](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.0.1...v1.0.2) (2020-04-28)


### Bug Fixes

* do not add leading and trailing slashes ([582355d](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/582355dc966ca9e447a7e1b73875b0f725334637))

## [1.0.1](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/compare/v1.0.0...v1.0.1) (2020-04-28)


### Bug Fixes

* unable to load slowlog_check.1.0.0.zip: no such file or directory ([97b845d](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/97b845d7b5a540ce5d7fd2adcccfecb349fb55b1))

# 1.0.0 (2020-04-27)


### Features

* provision lambda job with elasticache-slowlog-to-datadog v1.0.0 ([25da20f](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/commit/25da20fb0f801595361c4b502d3b73bab0d20e75))
