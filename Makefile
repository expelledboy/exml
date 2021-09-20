.DEFAULT: help

.PHONY: help
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: update-dep-repos
update-dep-repos:
	mix local.rebar --force
	mix local.hex --force

deps: mix.lock ## Install deps
	mix deps.get
	mix deps.compile
	touch deps

.PHONY: lint
lint: ## Run linters on source code
	mix format --check-formatted
	mix compile --warnings-as-errors
	mix credo

.PHONY: test
test: MIX_ENV := test
test: deps ## Run unit tests
	mix test \
		--warnings-as-errors \
		--cover \
		--export-coverage default \
		--timeout 120000
	mix test.coverage

priv/plts/dialyzer.plt: mix.lock
	mkdir -p priv/plts
	mix dialyzer --plt

.PHONY: dialyzer
dialyzer: priv/plts/dialyzer.plt ## Perform static code analysis
	mix dialyzer --no-check

.PHONY: ci
ci: deps lint test dialyzer ## Tests run before publishing

RELEASE_LEVEL = $(addprefix release-,major minor patch)

.PHONY: $(RELEASE_LEVEL)
$(RELEASE_LEVEL):
	LEVEL=$(@:release-%=%) make release

.PHONY: release
release: env-LEVEL ci
	git branch --no-color | grep -q '^\* master$$'
	git diff-index --quiet HEAD
	$(eval TAG := $(shell git describe --tags --abbrev=0 | sed 's/v//'))
	$(eval VERSION := $(shell ./scripts/bump.sh $(TAG) $(LEVEL) | sed 's/v//'))
	# Bump $(TAG) to $(VERSION)
	sed -i 's/version: "$(TAG)"/version: "$(VERSION)"/g' mix.exs
	sed -i 's/~> $(TAG)/~> $(VERSION)/g' README.md
	git add README.md mix.exs
	git commit -m 'Realease v$(VERSION)'
	git tag v$(VERSION)
	git push --force
	git push --tags

## => Utils

env-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
