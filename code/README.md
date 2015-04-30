# cs51finalproject
CS51 Final Project: Conway's Game of Social Life

TF: Marcus Powers, 
Members: Priscilla Guo, Anmol Gupta, Pierre Hirschler, Katherine Loboda

Instructions: In order to run the game, navigate to the FinalProject folder of the github repository cs51finalproject. Type into the command line "make". Then, run "./conway run userwebhistory". In order to test our project, we have provided some test input for userwebhistory and you can see the game evolve differently depending on the input used for userwebhistory. test.txt in the file folder “report”. Our parser utilizes the third argument of the command line argument array to decide the initialization seed of Conway's Game of Life. It analyzes how many social media websites are being visited by the user as well as the extent to which the user is examining trends from social media websites. Our project tries to assess both how socially active and aware the user is. Once you run the command, the terminal will also return to you the probability before trending, the number of social media websites visited, the number of trending sites, and the final probability after accounting for the number of trending sites. In the test.txt you can compare the outputs of the number of social media websites visited and the number of trending sites with the actual values to check for accuracy. 

    Report: Conway’s Game of Social Life allows a user to view his or her social history through a 
zero-player game. Technically speaking, it is a cellular automaton. The game depends on the initial 
state of the cells and is played on a grid, where the dots represent “alive” cells and the white spaces
represent “dead” cells. Every cell interacts with its eight neighbors. The cell will stay alive if it has 
either two or three neighbors. Another cell will be born only if there are three neighbors next to it. 
We based our initialization seed of the game, which is which cells were alive, on a user’s social website
history. We used probabilities to establish whether a cell was going to be alive or dead on the board 
for the initial parameters.
	We learned about a couple of different things in OCaml, such as try...with… (exception handling) or 
	begin...end.... We never used these structures in our p-sets and it was interesting to explore these 
	structures and how to use different modules in our project. We gained experience in creating helper 
	functions for our initialization seed and parser algorithm. For instance, we created a function that 
	would search for the substrings we desired in our continuous string of user history. The most important 
	things we learned are how to use git and how to build off existing modules and our partners’ codes. 
	By working with four different people on the project, we needed to learn how to properly use git so 
	that our project would properly function with all of the different pieces of code. Then, we had to learn 
	how to use different modules to fit our needs for this project, especially, since we were always given 
	what modules to use for our p-sets. Since, we all worked on different parts of the project, we learned 
	how to merge our two programs, paying attention to the functions created by other people on the project. 
    Original planning for our project was very reasonable. We were able to establish core functionality with 
    extensions on the algorithmic complexity of our project. After meeting with our TF, we decided to focus on 
    the algorithms of our project rather than the graphics/user experience. Milestones were achieved within the 
    allotted time deadlines. Although an error in the Makefile pushed our final project submission a bit back. 
    We were still able to achieve all the intended goals of our project. Each group member contributed equally 
   to the project. All group members worked on the code for the project. Anmol and Pierre handled the game 
   and the video. Katherine and Priscilla handled the parser and the social media algorithm and the project 
   write-up. 
	From our original design, we did evolve a variety of aspects. One aspect that was altered was the method
	 of user input. Originally, we had planned on inputting a user’s search history via CSV file from the 
	 command line. We would then have to write a CSV parser. However, we modified our design and decided to 
	 go through an easier route of string parsing. We ended up inputting a user’s search history directly 
	 into the command line as a continuous string in the third argument. This seemed to be the most 
	 effective and direct method. Another aspect of our game that we modified from our original design to 
	 make more complex is the algorithm that evaluated the social awareness of a user. We incorporated a 
	 users’ visits to trending sites. In other words, if a user paid attention to what hashtags were 
	 trending on each respective social media website, we would use the number of visits in our 
	 initialization seed of the game. We thought that we could better evaluate a user’s social awareness 
	 through this additional algorithm.
	The creativity of our program lies not within the graphics, which are just a white board with black 
	dots, but rather within the algorithm defining the initial probability of cells being alive. We had to 
	think about what would be the best way in which we could model a user’s social presence and ultimately 
	decided on focusing on the frequency of their social interactions and interest in trending topics. We 
	coupled these two factors in the board display. 
	Conway’s game of life has numerous real-life applications. It is used to model the growth of populations and the spreading of diseases. Our game depicts how a person’s social presence affects their presence on the world wide web. Currently we are all interconnected. A picture on Facebook can be accessed through Google and shared through Twitter. Our game takes Conway’s modeling of physical growth to the digital spectra. However, we did find it a  bit frustrating at times to adapt to website-based user input, since Ocaml is not well-equipped for that type of programming. Yet we were able to lay down the main functionality and test our code for accuracy. The patterns seen in our version of Conway’s game of life match up with the standard views. Additionally, we used print statements to output into the terminal the values the probabilities we were setting and how they were being affected by the user’s input. This method of print testing was crucial in testing the probability algorithms, which took a long time to integrate with the rest of the project. 
    Overall the project ran very smoothly, though we ran into a couple of unexpected problems as we progressed through our project. Some of these problems originated in the parser. After borrowing the Makefile from PSet 7, we had remnants in the file that were generating befuddling errors on our project. One of those errors included have an unbound module Event. We checked if the module was being called recursively within different files. However, those efforts were unsuccessful. Then, we attempted commenting out different sections of our code and finally in the Makefile and we realized that the line that we were using to compile the code didn’t need to reference Main.ml or Helpers.ml as the cows p-set did. We had never really had to write our own Makefile because that was always provided for us in our p-sets. So, it was a pleasant surprise to write our own Makefile. We had a different set-up so once we removed those files from OCamlC, our code was functional. Additionally, it was a difficult to tell if our code was working without relying on the errors. Once we had finished fixing the errors that the terminal was throwing, we also had to check if there were any conflicts with the rules of Conway’s Game and user input. So, we tested the game against each of the rules (i.e. 3 neighbors generate a new neighbor) and against a variety of user inputs to see if the program actually worked. Overall, our method of error checking was most effective because we were open to a diverse set of processes. One of the biggest pitfalls is to be adamant about certain pieces of code being correct but we made sure to test each part of our code. Another reason we were successful in achieving complete functionality was because we were able to utilize all the members’ input in fixing our errors. 
	If we had more time, we would add a generation limit and graphic on the screen that lets the player know the generation count. We would also add another component to the social media algorithm, in which we determine the initial parameters for the social game of life. For instance, we could add the number of visits to different user profiles; however, this becomes complicated because the access to user profiles is different on each social media website. We would also enhance the overall graphics of our game. 
	A future CS51 student might want to consider other variations on the classic Game of Life. It would be interesting to see other versions of the game. Also, I would advise a future CS51 student to set realistic core functionality goals and to focus on the algorithms of your game rather than the visual features/user experience. We would also advise future CS students to be adaptable from your original plan. 

Functionality: 
Please see original speculation draft in report.pdf. However, annotation is below of what we completed.

Core Features:
Graphic interface for Conway’s Game of Life
DONE
Interpretation of User’s Web Browser History
DONE.
Search Algorithm that will isolate social media websites from user’s web browser history
DONE. 
Algorithm that will translate number of visits to social media websites into initial configurations for Conway’s Game of Life
DONE. 
User Interface to Submit their Information and play the game
DONE. We used the command line for user input.

Cool Extensions: 
Expansion of Number of Social Media Websites
DONE. We expanded from three social media websites to four social media websites.
Create more outsets for the translation algorithm from information to initial configurations
DONE. We added amount time spent looking at trending hashtags on each social media website as a factor in our initialization seed algorithm.
Influence Conway’s Game of Life as it is being run with new user input
Not implemented. As we began to understand Conway’s Game of Life. 
Create cool graphics to accompany the game (i.e. color, shapes, changing colors/sizes)
Not implemented. We decided to focus instead on improving our algorithmic complexity.
Consider time spent on a website or number of profiles visited as a variable to influence the game algorithm of configuration initialization or search 
Not implemented. We decided to focus instead on improving our algorithmic complexity.


