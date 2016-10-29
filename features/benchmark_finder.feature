Feature: Benchmark Finder
    In order to find the benchmark for a given bond
    As a CLI
    I want to be able to run ...

    Scenario: No commands
        When I run `overbond find_benchmark`
        Then the output should contain "Usage:"

    Scenario: Really
        Given a file named "tmp/bonds" with:
        """
        bond,type,term,yield
        C1,corporate,10.3 years,5.30%
        G1,government,9.4 years,3.70%
        G2,government,12 years,4.80%
        """
        When I run `overbond find_benchmark C1 tmp/bonds`
        Then the output should contain:
        """
        bond,benchmark,spread_to_benchmark
        C1,G1,1.60%
        """

