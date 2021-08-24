# odin-connect-four

Description:

    This is a console application. Two users can play against each other to try to connect four of their markers horizontally, vertically, or diagonally.

    It was created in following the Ruby stream of The Odin Project under the heading: Testing Your Ruby Code. This section was geared towards test driven development.

    Some difficulties arose particularly with the diagonal pattern win algorithm, and some bugs are still present. They are difficult to  diagnose. Sometimes the user wins as expected and other times the computer doesn't seem to recognize the pattern. 

    Testing for this appliction is included in the spec folder. I used the testing particularly for the win functions to ensure they were working properly.


Future improvements:

    - diagnose diagonal wins issues
    - improve player_input function 
        - currently all letters are converted to 0 and accepted for column selection
    - create an AI so that players can play the game on their own


How to Use

    To use this application copy the files and in the console run the command: ruby lib/game.rb
    
    Instructions on how to play are included in the application.
