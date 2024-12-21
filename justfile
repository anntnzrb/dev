# prints this menu
default:
    @just --list

# fmt & check
fmt:
    pre-commit run --all-files

# fmt & check
pre-commit: fmt
