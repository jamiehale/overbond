Feature: Curve Spread Finder
    In order to find the spread to a yield curve for a set of corporate bonds
    As a command-line user
    I want to be able to run the spread_to_curve command

    Scenario: Usage
        When I run `overbond help spread_to_curve`
        Then the output should contain "Usage:"

    Scenario: A single corporate bond
        Given a file named "tmp/bonds" with:
        """
        bond,type,term,yield
        C1,corporate,10.3 years,5.30%
        G1,government,9.4 years,3.70%
        G2,government,12 years,4.80%
        """
        When I run `overbond spread_to_curve tmp/bonds`
        Then the output should contain:
        """
        bond,spread_to_curve
        C1,1.22%
        """

    Scenario: The small example
        Given a file named "tmp/bonds" with:
        """
        bond,type,term,yield
        C1,corporate,10.3 years,5.30%
        C2,corporate,15.2 years,8.30%
        G1,government,9.4 years,3.70%
        G2,government,12 years,4.80%
        G3,government,16.3 years,5.50%
        """
        When I run `overbond spread_to_curve tmp/bonds`
        Then the output should contain:
        """
        bond,spread_to_curve
        C1,1.22%
        C2,2.98%
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
        When I run `overbond spread_to_curve tmp/bonds`
        Then the output should contain:
        """
        bond,spread_to_curve
        C1,1.43%
        C2,1.63%
        C3,2.47%
        C4,2.27%
        C5,1.90%
        C6,1.57%
        C7,2.83%
        """

