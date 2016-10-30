Feature: Benchmark Finder
    In order to find the benchmark for a set of corporate bonds
    As a command-line user
    I want to be able to run the benchmark command

    Scenario: Usage
        When I run `overbond help benchmark`
        Then the output should contain "Usage:"

    Scenario: A single corporate bond
        Given a file named "tmp/bonds" with:
        """
        bond,type,term,yield
        C1,corporate,10.3 years,5.30%
        G1,government,9.4 years,3.70%
        G2,government,12 years,4.80%
        """
        When I run `overbond benchmark tmp/bonds`
        Then the output should contain:
        """
        bond,benchmark,spread_to_benchmark
        C1,G1,1.60%
        """

    Scenario: Multiple corporate bonds
        Given a file named "tmp/bonds" with:
        """
        bond,type,term,yield
        C1,corporate,1.3 years,3.30%
        C2,corporate,2.0 years,3.80%
        C3,corporate,5.2 years,5.30%
        C4,corporate,9.0 years,6.20%
        C5,corporate,10.1 years,6.40%
        C6,corporate,16.0 years,9.30%
        C7,corporate,22.9 years,12.30%
        G1,government,0.9 years,1.70%
        G2,government,2.3 years,2.30%
        G3,government,7.8 years,3.30%
        G4,government,12 years,5.50%
        G5,government,15.1 years,7.50%
        G6,government,24.2 years,9.80%
        """
        When I run `overbond benchmark tmp/bonds`
        Then the output should contain:
        """
        bond,benchmark,spread_to_benchmark
        C1,G1,1.60%
        C2,G2,1.50%
        C3,G3,2.00%
        C4,G3,2.90%
        C5,G4,0.90%
        C6,G5,1.80%
        C7,G6,2.50%
        """

