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
		--export-coverage default
		--timeout 120000
	mix test.coverage

priv/plts/dialyzer.plt: mix.lock
	mkdir -p priv/plts
	mix dialyzer --plt

.PHONY: dialyzer
dialyzer: priv/plts/dialyzer.plt ## Perform static code analysis
	mix dialyzer --no-check --halt-exit-status

.PHONY: ci
ci: lint test dialyzer ## Tests run before publishing
