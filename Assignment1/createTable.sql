/*##### Design
- Entities
    - Match
        - PK: MatchID
        - HomeTeamID
        - AwayTeamID
        - PointsForHomeTeam (0, 1, 3)
    - Teams
        - PK: TeamID
        - TeamName
        - HomeGround
        - Manager
        - Wins
        - Draws
        - Losses
        - GamesPlayed
    - Players
        - PK: PlayerID
        - Name
        - SquadNumber
        - TeamID
    - Goals
        - PK: MatchID and Minute
        - PlayerID
    - PositionsFile
        - PK: MatchID
    - Substitutions
        - PK: MatchID and TeamID
        - PlayerOffID
        - PlayerOnID
        - Minute
    - StartingLinup
        - PK: TeamID and MatchID
        - Players
            - Multi-Valued
    - PlayersSentOff
        - PK: MatchID
        - Minute
        - PlayerID

Assumptions - player Squadnum doesn't change */

/*Create tables*/
CREATE TABLE Matches (
    MatchID INT(20) NOT NULL,
    HomeTeamID INT(20) NOT NULL,
    AwayTeamID INT(20) NOT NULL,
    PointsForHomeTeam INT(3) DEFAULT NULL,
    PointsForAwayTeam INT(3) DEFAULT NULL,
    PRIMARY KEY (MatchID)
);

CREATE TABLE Teams (
    TeamID INT(20) NOT NULL,
    TeamName VARCHAR(50) DEFAULT NULL,
    HomeGround VARCHAR(50) DEFAULT NULL,
    Manager VARCHAR(50) DEFAULT NULL,
    Wins INT(20) DEFAULT NULL,
    Draws INT(20) DEFAULT NULL,
    Losses INT(20) DEFAULT NULL,
    GamesPlayed INT(20) DEFAULT NULL,
    PRIMARY KEY (TeamID)
);


CREATE TABLE Players (
    PlayerID INT(20) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    SquadNumber INT DEFAULT NULL,
    TeamID INT DEFAULT NULL,
    PRIMARY KEY (PlayerID),
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE Goals (
    MatchID INT(20) NOT NULL,
    Minute INT(20) NOT NULL,
    PlayerID INT(20) NOT NULL,
    PRIMARY KEY (MatchID, Minute),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)   
);

CREATE TABLE PositionsFile (
    MatchID INT NOT NULL,
    PositionsFile VARCHAR(50) NOT NULL,
    PRIMARY KEY (MatchID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

CREATE TABLE Substitutions (
    MatchID INT(20) NOT NULL,
    TeamID INT(20) NOT NULL,
    PlayerOffID INT(20) NOT NULL,
    PlayerOnID INT(20) NOT NULL,
    Minute INT(20) NOT NULL,
    PRIMARY KEY (MatchID, TeamID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerOffID) REFERENCES Players(PlayerID),
    FOREIGN KEY (PlayerOnID) REFERENCES Players(PlayerID)
);

CREATE TABLE StartingPlayers (
    MatchID INT(20) NOT NULL,
    TeamID INT(20) NOT NULL,
    PlayerID INT(20) NOT NULL,
    PRIMARY KEY (MatchID, TeamID, PlayerID)
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

CREATE TABLE PlayersSentOff (
    MatchID INT NOT NULL,
    Minute INT NOT NULL,
    PlayerID INT NOT NULL,
    PRIMARY KEY (MatchID)
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

/*Populate tables */
INSERT INTO Teams (TeamID, TeamName, HomeGround, Manager, Wins, Draws, Losses, GamesPlayed)
VALUES 
(1, 'Liverpool', 'Anfield', 'Jurgen Klopp', 2, 1, 2, 6), 
(2, 'Manchester City', 'Etihad Stadium', 'Pep Guardiola', 1, 1, 2, 4), 
(3, 'Manchester United', 'Old Trafford', 'Ole Gunnar Solskjaer', 0, 2, 2, 4), 
(4, 'Chelsea', 'Stamford Bridge', 'Frank Lampard', 3, 3, 0, 6);

INSERT INTO Matches (MatchID, HomeTeamID, AwayTeamID, PointsForHomeTeam, PointsForAwayTeam)
VALUES
(1, 1, 2, 3, 0),
(2, 3, 4, 0, 3),
(3, 1, 4, 1, 1),
(4, 2, 4, 0, 3),
(5, 4, 1, 1, 1),
(6, 3, 1, 0, 3),
(7, 2, 3, 1, 1),
(8, 1, 4, 0, 3),
(9, 2, 1, 3, 0),
(10, 4, 3, 1, 1);

INSERT INTO Players (PlayerID, Name, SquadNumber, TeamID)
VALUES
(1, 'Liam Holland', 2, 1),
(2, 'Cathal Lawlor', 7, 2),
(3, 'GitHub Copilot', 9, 3),
(4, 'Man 4', 9, 4),
(5, 'Man 5', 11, 1),
(6, 'Man 6', 10, 2),
(7, 'Man 7', 3, 3),
(8, 'Man 8', 5, 4),
(9, 'Man 9', 8, 1),
(10, 'Man 10', 6, 2),
(11, 'Man 11', 4, 3),
(12, 'Man 12', 12, 4),
(13, 'Man 13', 15, 1),
(14, 'Man 14', 14, 2),
(15, 'Man 15', 13, 3),
(16, 'Man 16', 1, 4);

INSERT INTO Goals (MatchID, Minute, PlayerID)
VALUES
(1, 40, 1),
(2, 12, 16),
(2, 77, 16),
(4, 50, 12),
(5, 33, 1),
(5, 65, 16),
(6, 4, 9),
(7, 23, 2),
(7, 66, 3),
(8, 3, 8),
(8, 5, 8),
(9, 89, 2),
(9, 91, 2),
(10, 1, 16),
(10, 95, 11);


