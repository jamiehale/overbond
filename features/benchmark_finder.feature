Feature: Benchmark Finder
    In order to find the benchmark for a given bond
    As a CLI
    I want to be able to run ...

    Scenario: No commands
        When I run `overbond find_benchmark`
        Then the output should contain "Usage:"

