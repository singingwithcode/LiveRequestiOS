# LiveRequestiOS
Live Request iOS App

Runs in XCode

Storage:
All data is stored in Event.swift which is inside a project scope Event array. Each event contains the name, an event code, an admin code, and a Song list. The song list keeps track of all the songs for an event. Inside a Song, there is the name of the artist, the song name, and the Votes for the song. Inside Votes, we encapsulate, similar to a singleton design pattern, the votes for a song. In order to cast a vote, you need to have a valid username. You cannot access the votes directly and must have vote call a get method. The only way to cast a vote is with a username and whether the vote is UP, DOWN, or NONE . NONE means the user no longer has a vote on the song but we still want to keep track if they said anything. We do not want users handling the increase or decrease on a song. We also have a Vote count itself to return the correct number of votes on that particular song. 

Test Data:
Test data is hardcoded inside Event.swift to demonstrate the app’s full capability. All codes (Admin Code and Event Code) for the Sample Event are “admin”. You may delete the event if you iterate to the Admin page.
Segues:
All segues between scenes pass an Event. The only scenes that do not need an Event is the root ViewController.swift and EventCompileViewController.swift. Both of these create or display the events. 

Navigation controller:
The navigation of the app is through a navigationController. A logo is placed in the center and a back arrow will appear to backtrack navigation. On all views but the root, we have to insert blank spaces on the right to properly center the logo since an arrow will appear on the left, pushing the logo to the right.

Event List Screen (app startup Screen):
ViewController.swift
Upon startup, if there are no items in the list, the list will appear blank. From this screen you can either select any part of the row or click the Start An Event. If you select a row, an Event is passed to ViewControllerEventCode.swift. If you click to Start An Event, nothing is passed to EventCompileViewController.swift. At the base of this screen is a navigation controller for iterating through the app. Again, this is one of two screen that do not need an Event. A cell on this screen uses a separate prototype class called TableViewCellEvent. That way we have an outlet per cell for the ViewController.swift.

Event Compilation Screen:
EventCompileViewController.swift
This will appear after the Start an Event Screen is clicked and is a bit more complex than you think. There is a validation to check to see if there is input on all fields. When a text box is clicked, the keyboard pops up. If it is the first or second box, the Done button will  dismiss the keyboard. If the second or third box is selected, the view will shift up so the keyboard does not cover the fields. The Done button on the third box will submit the event along with the Submit button or a double click gesture to the screen. The gesture can be made at any time and will alert if proper requirements are not met. Upon approved submission, we segue to ViewControllerEventAdmin. Since there are no songs entered on this Event yet, there will be no rows. We can also cancel adding an event by using the arrow at the top. 

Event Code Screen:
ViewControllerEventCode.swift
We can reach this screen after clicking on an Event in the root view ViewController.swift. The Event will be passed to ViewControllerEventCode.swift and the Event’s name will be filled. If we click on the event code box, the view will shift up allowing the keyboard to not cover the box. We can submit the code in 3 ways: the keyboard, the Submit button, or by double clicking the screen. If the code is not valid, a message will pop up telling the user that: there is no input or the code is incorrect. Upon correct code, the will segue to ViewControllerSongList.swift. We can also navigate back to the list of events ViewController.swift.

Song List Screen:
ViewControllerSongList.swift
We can reach this screen after the proper code is entered on ViewControllerEventCode.swift. The Event with the song list is sent to this view and updated in a table view. The number (in blue) displayed is the total number of votes, including from other users. The code is designed to handle multiple users but the userID of integer 1 is currently hard coded into the app. The reason is discussed in the Storage section. The arrows on each row are drawn with quartz. Each cell utilizes TableViewCellSong.swift as it is a separate prototype class to handle all outlets for each cell. We can upvote and downvote songs by sliding the row left or right. Once a row has been upvoted or downvoted, the number will change with your vote. You can only vote once on each song but can always change it. The state of the row is stored in Vote which lives in each Song, also discussed in Storage. From this screen, as an admin, we can manage the event by clicking the manage button at the bottom of the screen which will segue to ViewControllerAdminCode.swift. If we add a song, it will appear at the bottom of the list with a vote of zero. We can also add a song by clicking on the add song button that will segue to ViewControllerSongAdd.swift. We can always navigate back to change to a different event. 

Add Song Screen:
ViewControllerSongAdd.swift
This will appear after the Add Song button is clicked from  ViewControllerSongList.swift. Here you can enter the song name and artist to be added to the song list. There is a validation to check to see if there is input on all fields. When a text box is clicked, the keyboard pops up. If it is the first box, the Done button will dismiss the keyboard. If the second box is selected, the view will shift up so the keyboard does not cover the field. The Done button on the second box will also submit the event along with the Submit button at the bottom or a double click gesture to the screen. The gesture can be made at any time and will alert if proper requirements are not met. Upon approved submission, we dismiss the view to fold back to the event list where it will be updated with the new list. We can also cancel adding a song by using the arrow at the top.

Admin Code Screen:
ViewControllerAdminCode.swift
This will appear after the manage button is clicked on ViewControllerSongList.swift. The Event will be passed and the Event’s name will be filled. If we click on the event code box, the view will shift up allowing the keyboard to not cover the box. We can submit the code in 3 ways: the keyboard, the Submit button, or by double clicking the screen. If the code is not valid, a message will pop up telling the user that: there is no input or the code is incorrect. Upon correct code, the will segue to ViewControllerEventAdmin.swift. We can also navigate back to the list of song by the arrow at the top.


Admin Event Screen:
ViewControllerEventAdmin.swift
This will appear after ViewControllerAdminCode.swift is successful. The event is passed and the songs fill the rows. The number trash can image is shows the direction in which you must slide to delete a row. Each cell utilizes TableViewCellAdmin.swift as it is a separate prototype class to handle all outlets for each cell. The state of the row is stored in Song, discussed in Storage. From this screen, as an admin, we can end an event by clicking the End Event button at the bottom of the screen. Upon click, the user will be prompted to confirm this deletion. This will remove the Event and all its contents and unwind to the root view. Or we can cancel in the prompt and return to the admin view.
