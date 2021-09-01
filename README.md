# Phase 3 Code Challenge: Elections

For this assignment, we'll be working with an election.

We have three models: `Candidate`, `Ballot`, and `Voter`.

For our purposes, a `Candidate` has many `Ballots`, a `Voter` has many `Ballots`, and a
`Ballot` belongs to a `Candidate` and to an `Voter`.

`Candidate` - `Voter` is a many to many relationship.

## Instructions

To get started, run bundle install while inside of this directory.

Build out all of the methods listed in the deliverables. The methods are listed in a suggested order, but you can feel free to tackle the ones you think are easiest. Be careful: some of the later methods rely on earlier ones.

Remember! This code challenge does not have tests. You cannot run rspec and you cannot run learn. You'll need to create your own sample instances so that you can try out your code on your own. Make sure your associations and methods work in the console before submitting.

We've provided you with a tool that you can use to test your code. To use it, run rake console from the command line. This will start a pry session with your classes defined. You can test out the methods that you write here. You are also encouraged to use the seeds.rb file to create sample data to test your models and associations.

Writing error-free code is more important than completing all of the deliverables listed - prioritize writing methods that work over writing more methods that don't work. You should test your code in the console as you write.

Similarly, messy code that works is better than clean code that doesn't. First, prioritize getting things working. Then, if there is time at the end, refactor your code to adhere to best practices.

Before you submit! Save and run your code to verify that it works as you expect. If you have any methods that are not working yet, feel free to leave comments describing your progress.

## What You Already Have

The starter code has migrations and empty model files for the initial `Voter` and `Candidate`
models, and seed data for some `Voters` and `Candidates`. The schema looks like this:

### Voters Table

| Column              | Type    |
| ------------------- | ------- |
| name                | String  |
| age                 | Integer |
| party               | String  |

### Candidates Table

| Column              | Type    |
| ------------------- | ------- |
| name                | String  |
| party               | String  |
| seat                | String  |

You will need to create the migration for the `Ballots` table using the attributes specified in the deliverables below.

## Deliverables

Write the following methods in the classes in the files provided. Feel free to build out any helper methods if needed.

Deliverables use the notation # for instance methods, and . for class methods.

Remember: Active Record give your classes access to a lot of built-in methods! Keep in mind what methods Active Record gives you access to on each of your classes when you're approaching the deliverables below.
Migrations

Before working on the rest of the deliverables, you will need to create a migration for the `ballots` table.

A `Ballot` belongs to a `Candidate`, and a `Ballot` belongs to a `Voter`. In your migration, create any columns your `Ballot` table will need to establish these relationships. The ballots table should also have an `election_year` column that stores an integer.

After creating your migration, use the seeds.rb file to create instances of your Ballot class so you can test your code.

Once you've set up your Ballot class, work on building out the following deliverables.

### Object Relationship Methods

Use Active Record association macros and Active Record query methods where
appropriate (i.e. `has_many`, `has_many through`, and `belongs_to`).

#### Ballot

- `Ballot#voter`
  - should return the `Voter` instance for this ballot
- `Ballot#candidate`
  - should return the `Candidate` instance for this ballot

#### Candidate

- `Candidate#ballots`
  - returns a collection of all the ballots for the candidate
- `Candidate#voters`
  - returns a collection of all the voters who voted for the candidate

#### Voter

- `Voter#ballots`
  - should return a collection of all the ballots that the voter has cast
- `Voter#candidates`
  - should return a collection of all the candidates that the voter has voted for

Use `rake console` and check that these methods work before proceeding. For
example, you should be able to call `Voter.first.candidates` and see a list of the
candidates for the first voter in the database based on your seed data; and
`Ballot.first.voter` should return the voter for the first ballot in the database.

### Other Methods


#### Candidate
- `Candidate#count_votes(year)`
  - takes a `year` (integer) as an argument, and returns the amount of ballots cast for the candidate that year
- `Candidate#most_popular_year
  - returns the candidate's most successful election year (the year where this candidate had the most ballots cast for them)
- `Candidate#voters_in_party_below_age(party, age)`
  - takes a `party` (string) and `age` (integer) as arguments, and returns all voters who have voted for this candidate who belong to the given political party, and are YOUNGER than the given age
- `Candidate.seats_in_party(party)`
  - takes a `party` (string) as an argument and returns an array of all seats that candidates belonging to that party are running for.
- `Candidate.most_popular_for(seat)`
  - takes a `seat` (string) as an argument, and returns the Candidate with the most ballots cast who is running for the given seat

#### Voter
- `Voter#vote(candidate, year)`
  - takes a `candidate` (an instance of the `Candidate` class) and a `year` (integer) as arguments, and creates a new `ballot` in the database associated with the candidate and the voter
- `Voter#votes_across_party_lines`
  - returns all `Candidate` instances that this voter has cast a ballot for whose political party does not match their own
- `Voter.voted_in(year)`
  - takes a `year` (integer) and returns all voters who cast ballots during that year
- `Voter.in_party_above_age(party, age)`
  - takes in a `party` (string) and an `age` (integer) and returns all voters that belong to the party, and are OLDER THAN the given age
- `Voter.voted_for(candidate)`
  - takes a candidate (instance of a Candidate) argument, and returns all voters who have cast a ballot for that candidate

#### Ballot
- `Ballot#print_details`
  - `puts` a string to the terminal to display the details of the ballot
  - the string should be formatted like this: `{voter name} voted for {candidate name} in ${ballot year}`
- `Ballot.most_popular_year`
  - returns the year during which the most ballots were cast

