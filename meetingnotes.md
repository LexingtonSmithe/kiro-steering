Sep 16, 2026
Lex / Aymeric - Transcript
00:00:00

Aymeric Obled: faster than they have time to do stuff.


00:00:02

Aymeric Obled: So I really do think that devs needs to follow the task like from the beginning coding pushing for the review and on this done doing a first QA like really on the side before asking someone else to QA and already if everyone was taking this responsibility of okay this is my task it's supposed to work like this we define this and when I say it's done it's done is because I pasted like then you can do mistakes you can forget things but that at least you did the full flow and you know that your task seems to be on your side. And this I think is the first big step which could help everyone to save time and to and to do this and this to do this we need to have what we need to do well what we need to be able to test because there is a lot of things now that it's difficult to test locally so then you end up merging already in UAT to test that things are working so then well with the last Tony did about you testing UAT and once it's done you travel pick and you push to master this is later but that's what we were doing before like in ticketing where you have UAT and then we merge all UAT to master to deploy then you always end up with some stuff which was not finished because someone was fixing stuff and it's blocking everyone or you need to revert or and this I think is quite painful to for the one coding too because it's a bit stuff then everything


00:01:23

Aymeric Obled: is reverted because you need to deploy then you have to put back again you have to fit a loss of time for everyone
Lex Lowndes: So um with the I mean the merging strategy is is definitely something that that can be looked at because I think I think you're right just sort of merging in Tony's way of of cherry picking it is basically using feature branches isn't it um which is which is what we use um
Aymeric Obled: Mhm.
Lex Lowndes: like we'll have a feature branch we'll e we'll deploy just that feature branch to whatever environment test it against the other things or even just run it locally uh and point your local at a staging or UAT environment. So, for example, if you're running like a um if you're testing a a new booking portal or ticket shop feature, ticket shop runs locally and it hits staging um APIs and stuff like that.
Aymeric Obled: Mhm.
Lex Lowndes: Uh I definitely think that's something that could be done here. I've I don't I don't fully understand what this what why why we're doing why we're running that sort of like mainline strategy when we don't necessarily have that much confidence in in


00:02:48

Aymeric Obled: I think basically you can do more or less a lot of things on your computer but what devs are complaining is that you don't have a lot of data on your local environment because it's like just test data but it's not representing what you could have enough full event so this I think we could anonymize some data from prod and have it locally to at least do proper testing because I swear if you have 10 transactions it's not the same as if you have a with complex load and stuff like this.
Lex Lowndes: Mhm.
Aymeric Obled: And then you have things that know like even more now that we started doing more microservices that if you want to run something like but it's in all the team that you have this issue that you have something that you need to have on staging other ones locally because for example to do payments and stuff like this if you want to take a full flow it's difficult to have on your computer like running uh the widget the back end like it's well our computers cannot run like 10 apps at the same time to be able to test everything locally but maybe we need to do it better like okay part of it is running on staging then locally I have only what I need to test if I do front end I have my front end but then the rest can be staging and yeah I think


00:03:55

Aymeric Obled: the most difficult one now is to test especially between the services which have to sync between themsel like to create someone in ticketing is arriving to whispay and all the things like locally it's difficult to have everything so that's why a lot
Lex Lowndes: Mhm.
Aymeric Obled: of people are testing on your while you have all the things the workers like everything already running But yeah, I think we need to find a way to to improve and I think having more data locally already should help to test more stuff too.
Lex Lowndes: So I have I've got absolutely no problem with using UAT as the testing environment.
Aymeric Obled: Mhm.
Lex Lowndes: The the the issue comes in in how you get it to onto UAT. So to get it to get it onto UAT,
Aymeric Obled: Mhm.
Lex Lowndes: you currently merge it in, don't you? And then it gets support to UAT.
Aymeric Obled: Uhhuh.
Lex Lowndes: rather that and at that point if something's wrong it's merged and it's like a whole thing like could we not just deploy a a a branch to UAT of a


00:04:52

Aymeric Obled: What?
Lex Lowndes: particular like rather than rather than merge it in and then wait and then test the like full thing.
Aymeric Obled: Mhm. Well, for example, what we do for the mobile app is that in every branch should do, you have an APK build. Every time every time someone is doing a commit is building a new APK. So then, well, I don't know if you already saw, but the POS or whoever ones, you can test with big part of them are broken, but I'm going to show you. It's not crushing my computer. Uh but if you check for example blendy which is our Android app every time you have the links like okay if you want to test this pull request download this APK on your
Lex Lowndes: Mhm.
Aymeric Obled: device and this is the code of this branch that you can test like it's not merge it's not anything and once you're sure it's okay then you can merge and basically you take wireless ring a risk because you didn't merge for nothing and when you merge it because you pass the QA basically for front end it's quite easy too because it's just like deploying HTML file and stuff like this.


00:05:58

Lex Lowndes: Yeah,
Aymeric Obled: So it's easy.
Lex Lowndes: it's if something is in the if something is in the middle of the architecture and you
Aymeric Obled: But
Lex Lowndes: want to just test a branch of what like say a microser something like that you can you can points you can you can interact with the front end, but then front end's going to interact with the UAT version of this. Um, you'd have to actually physically deploy it out to something. But again, that's just a case of doing it like like this, like putting this what is it the um
Aymeric Obled: Because in the end you could also say to the P like hey pull the branch on your computer and test. But it's taking a lot of time to do this. So we need to help ourselves and like hey okay just do this don't the APK it's already ready for front end the same. What you wanted to do is that in each branch you already have a link like hey if you want to see the preview of what has been done click here.


00:06:51

Aymeric Obled: is going to call to to talk to UAT while the back end of UIT and that's fine.
Lex Lowndes: Mhm.
Aymeric Obled: I mean when you do dev on front end usually we are plugged to UAT to like almost never to the to the local environment. The more difficult is for the back end because to create a new database environment and everything every time you want to test it's a bit trickier but I know that when I was talking with Alex from well the kabuda he was saying that it could be nice even without having a ton of envelopment just one extra branch like I don't know like or something like this and where you can say like hey on this environment I want this branch to be running right now so you can test
Lex Lowndes: Yes.
Aymeric Obled: already there like I don't know if tag or a flag or something to say like hey I want this request deployed in our test
Lex Lowndes: Yeah, that's that's exactly um that's exactly the setup that I would like to to do. So, testing something in isolation,


00:07:50

Aymeric Obled: Mhm.
Lex Lowndes: I don't I don't mind if it's on local or if it's on UAT, but I think the problem with the current setup is is that it's master on UAT rather than a feature branch.
Aymeric Obled: I think
Lex Lowndes: So it could be like you you like like you say you want to put just just this back back end just the this branch of the back end on staging and then you run that against everything else that's there. Um like how how diff how difficult would that be to implement as a process? Obviously,
Aymeric Obled: N can be done.
Lex Lowndes: obviously bearing in mind that we at the moment we don't have currently do any testing but if we did if we were if we wanted to if we said to the developers you have to test it before you merge and the way and oh I can't test it locally. Okay, well great we've got this new strategy put your branch on a thing test it then you then once it passes then you can merge it. How would how do you think that would go?


00:08:52

Aymeric Obled: Well, it's quite a lot of work I think for mainly for production team more than us to have all the environments for you deploy and stuff like this. But in the end back end we don't have that much issues because you have a lot of unique testing and stuff like this. We have a lot of C flags. So usually when you do a new feature changes it's behind a slide which is not enabled by default and
Lex Lowndes: Mhm.
Aymeric Obled: then well we enable it like to test on some models and stuff like this. But that's true that uh it can be nice depending on what you're working on. Sometimes to have real environment where you can test like export where you can test stuff like if real data and stuff like this we would need to do I don't know how long it would take
Lex Lowndes: But well the um this is a very minor thing but it's not really feature flags is it is it is system configuration
Aymeric Obled: well that you can enable organizer by organizer and stuff like this.


00:09:43

Lex Lowndes: which yeah it's just slight it's slightly less safe. Uh, and also, um, I think I can't remember who I spoke to, but somebody said that, uh, users can change those flags themselves.
Aymeric Obled: Well, this no this we decide that we can we have a a flag when we add a new one to decide if it if it can be changed by the user. So if you need to have a well production access to to change the flag like if it's not a big thing then we let it like so that they can change from the UI but if not we can block it and it's only done from the back but you know it could be a good test to to be able to test really because if you do a small back end fix or future well it's fine but when you start doing big refactoring or stuff like this you need to be able to test properly. You cannot just send and say like,"Hey, good luck. Let's see if it's working." For example,
Lex Lowndes: Yeah. Also like the other thing as well is If we don't do any testing before it's merged in and it's on production, even if we have a feature flag, one of the one of like the first tests that you would do against something like that is feature flag integrity.


00:10:52

Lex Lowndes: So, does it with it switched off, does everything work as normal? Like have you can you in like ensure basic regression and then yeah, okay, that's fine. Well, then you can release it and then we can test it in isolation with it maybe turned on for a specific user or something like that.
Aymeric Obled: What's that?
Lex Lowndes: But there's no there's no sanity check around the integrity of the system configurations that we're currently using as well. So it's that also doesn't feel safe for me. But
Aymeric Obled: to give you to give you some context like some years ago we say four or five years we had only master so it was like you were imaging to master then you were deploying and that was it but then the team started growing those were more people new people so we needed more reviews more QA more stuff so that's why we created UT like in a way like okay at least you can test on UT and if you have not fixed% time we don't have to deploy untested things like we can we have master always ready to go so we just send our work to master we deploy and it's not sending other features but now we end up with UT that in the end is blocking for quite some time then sometimes you deploy UT you have 50 commits like it's impossible


00:12:01

Aymeric Obled: to review and to check everything when you have two weeks of work so we should deploy I'm more into the team of deploying like every day but like one small thing that you tested and then it's fine and then you send everything that waiting one full week and spend one full day to cure everything which for sure you're going to miss things. there.
Lex Lowndes: Um, I I just realized I didn't I had a question about what you were saying a second ago. Um, the wheat production team, you said in order for us to be able to deploy branches to UAT, they would need to be involved.
Aymeric Obled: Well, to do the setup once the setup is done with the extra database and stuff like this, then we can do it on our own. But it's more like to create the setup that if you deploy if you put this flag then we have to deploy to AWS and all the things then this yeah we need the production team to help us. I mean we could do on our own but it's more devops to do the setup.


00:12:59

Aymeric Obled: I mean then once it's done it's easy for us to play and to do stuff but to do the setup in the beginning usually we need a deops or someone to help us to do the setup but it's for all the teams.
Lex Lowndes: Okay.
Aymeric Obled: If we do it would be useful for ticketing. It would be useful for everyone. So it's not like um
Lex Lowndes: Yeah, definitely. Um I think it might so we we use GCP and yeah we tag it up as either QA1 or RC1 or whatever and then we just go into the the the console and we just change over the traffic from whatever it currently is to whatever we need it to be on staging staging staging is then that branch um or yeah um that's that's primary way of doing it I think okay um so engage with production team to enable us to deploy specific branches to that okay so if developers are able to deploy branches to UAT um and they are forced at gunpoint to test um the work. The major hurdle I think probably there is something that came up in the thread either yesterday or the day before with


00:14:25

Aymeric Obled: Uh
Lex Lowndes: Pavle. What do they test? I don't think they fully know what they actually need to do when it comes to QA. And how do we how do we ensure that they've got better understanding of what goes into QA?
Aymeric Obled: yeah, I know this is a problem you have and I know that sometimes when mainly POS when they
Lex Lowndes: There we go.
Aymeric Obled: are complaining that it hasn't been tested or stuff like this while it happening sometimes that you open the app it's crashing then this is the fault of the day but there is also things they cannot know every single feature they cannot know everything to test so if at least we had a list I think when you prepare the user stories or stuff like this we should have a list of hey we need to do this check this this this this this if then when we do the testing is not matching well this is the fault of the dev because it didn't do what you have to do but if not it's difficult to know all the flows to test all the I mean we should define it before we cannot expect everyone know every single flow to test but yeah I do agree we need to have where to test but we need to know what to test Oh, wait.


00:15:29

Lex Lowndes: Yeah, I think that's definitely something I can get the products guys to to to to look at because I think what the problem is is they go, I'm going to be the one testing it. I don't need to write it down. And then the developer goes, well, I don't know what you are going to check, so I don't know what to check, so I just got to I'll do I'll just very I'll load it up. Yeah, it looks fine. You're going to do whatever you want to do, and that's a mystery to me. Go do it. So, if the products are more upfront with what they're going to do in the ticket, then that could then potentially be done by a developer.
Aymeric Obled: and in the end maybe you forgot things in the user story or stuff like this but by putting what you have to test even the dev is going to say like oh I need to code like this because I shouldn't forget that we need to have this working and this working and this working better than doing the full thing forgetting about some flaws and then you end up you try and then it's not working


00:16:17

Lex Lowndes: Could
Aymeric Obled: and you have to change a ton of things because you didn't plan some of the cases. In the end, it could be easier to spend more time before ensuring that you're all aligning on what it has to do than doing the dev and then discovering that you miss stuff and you have to change a lot of things.
Lex Lowndes: that be like um could that maybe be We call incorporated into the like a story kickoff. So um once you have your user story and your acceptance criteria you go right okay this is it let's write together product and developers write a test plan or at least a brief one maybe maybe during that that because
Aymeric Obled: Yeah, it is good.
Lex Lowndes: this is the thing I I I think the developers are going to be able to add to the test plan and it shouldn't just be product give me a test plan it should be we should write one together.
Aymeric Obled: And I think one bad thing we have because we are doing kick off for the feature. So this is nice because one or two years ago we were not doing all the time.


00:17:21

Aymeric Obled: But the issue we have with our kickoff is that basically is POS presenting us the user stories a bit and devs arriving and discovering the topic in the kickoff.
Lex Lowndes: Yes.
Aymeric Obled: So in the end if you arrive then we want to do we want to do the to create the task but we cannot because defite we don't even know what is going to talk about so you cannot write defects if it's easy once you can do it easily but if it's a big topic you cannot just write it live you need to check the code then you cannot do estimation because if you don't know what you have to do you cannot do estimation then thinking about testing as you don't know the code you're going to touch well it's difficult to do the things and I think if you arrive in the kickoff or maybe you like a short meeting where the t is presenting the fe we need to do then the dev doing the specs checking the code checking everything and that then we align again before starting like hey I think we should do this like this but that at least the meetings are useful because if you arrive and the dev didn't know what he was going to do it's difficult to estimate to write testing and what do you do in kudal for when you have a new feature to do for


00:18:24

Lex Lowndes: Okay.
Aymeric Obled: example the pure ising the your specs.
Lex Lowndes: Uh, so the tickets arrive in a variety of different states. Some very very empty with just like a line and it's like here we've got a problem. What do we do? And then we'll come up with how we're going to solve it, different ways of solving it. So, um, what was it that we were looking at the other day? Like hot tubs, hot tub time session based stuff. And we were like,"Oh, we could do it um we could present it like um like per hot tub or we could do it with like time series." like we we actually just sort of like ran it through like that and then we said okay if this is roughly what we want to do let's take it away. So we went away did a little bit of investigation we came back and we said yeah we can probably do like this and this is what our competitors do then we built on it like that and then we just basically did like two or three of those different refinements where each time it got closer and closer to a finished ticket.


00:19:32

Lex Lowndes: Um and at the end was that that was at the stage we were like okay we know exactly what the problem is is we need to sell sessionbased hot tubs as an extra. We know where it's going to live, where we're going to get the data. Um, we know how we're going to present it. And these are like the different um sort of like things that it needs to do in terms of like needs to display a from price on the card category and then like a specific price on the day or or the time or whatever. You need to be able to share it, reserve, all that sort of stuff. And then we added in the acceptance criteria of that. And it had a a reasonably good breakdown of the different types of stories as well. like it's it's it's a granular process. You don't just have one meeting.
Aymeric Obled: Mhm.
Lex Lowndes: Um so a a kickoff should be probably a problem and maybe a loose idea of what to do and then come up with an idea together.


00:20:26

Aymeric Obled: Well, I think you saw it by talking with POS and devs when I leads mainly but I think we don't work enough as a team with POS and it's like POS are doing their things on their sides then dropping us the bone like okay you have to do this us are doing the specs and everything then it's not matching instead of I mean POS needs to start a bit before us on the topic because they at least to see what we will have to do.
Lex Lowndes: Mhm.
Aymeric Obled: But I think it should be more like a teamwork to prepare like the precise specs to challenge what you're doing and stuff like this and to feel devs and leads more involved in what they're doing because no you just rec you just receive specs and your specs and it's like okay now we need to cut but I think we should be involved and doing things way before all together and step by step not just arriving in one meeting saying okay the kickoff and that's done.
Lex Lowndes: Yeah, I've I I definitely think that's something that needs to change.


00:21:24

Lex Lowndes: And I kind of I'm I'm waiting for Baptist to come back off holiday because that's something obviously that he needs to he needs to drive in terms of like making sure that what gets brought to the teams is is in a particular state.
Aymeric Obled: Mhm.
Lex Lowndes: Something you said there is really has come up in every single conversation I've had and it's definitely something I think as well which is there is no team.
Aymeric Obled: Mhm.
Lex Lowndes: There's no teamwork. There's not even a There's not even a product versus devs. There's not There's no It's like 10 individuals all sort of like doing their own different thing. And at the end of it, sometimes there's a feature that's useful and sometimes there's a handful of bugs and it's like we don't really know which. It's like there's no collaboration, I guess. Um, which is partly driven by the fact that I think what was the comment? 10 10 developers each uh and then 10 topics. So they never they don't get a chance to work with together.


00:22:27

Lex Lowndes: But also the the way that the products are lined up as well.
Aymeric Obled: Yummy.
Lex Lowndes: I think it'd be good good to address sort of like the the team element.
Aymeric Obled: Mhm.
Lex Lowndes: Get some like get maybe like a sense of identity. You know what? Whether or not we want to have two teams like folk and no funk and antifolk.
Aymeric Obled: Uhhuh.
Lex Lowndes: Um both both of them beginning with F is really irritating.
Aymeric Obled: Uhhuh. But in the end,
Lex Lowndes: Um
Aymeric Obled: one of the things I wanted to do because before we didn't have Tony, the squad lead of Funk, so it was me having to manage the team too. But now that is here the goal was well what I had in my opinion and that I discussed with the leads it was to split really in two teams and to split the product basically in two and to have like one team is one
Lex Lowndes: Mhm.
Aymeric Obled: lead one PO and be and that they are responsible of 50% of the topic then


00:23:16

Lex Lowndes: Yep.
Aymeric Obled: we decide of the project I mean but then we decide or we split but like that they work by features like someone is responsible about payment someone is responsible about dashboards or stuff like this let's see how we split But that I would like because having the full product I mean it's a lot of things and it's difficult for them to know everything. But I feel that if they had a more limited scope they could also take responsibilities like hey we could improve this page. We saw a bug there like we can fix and this kind of thing and to work like more as a team to be like a team of
Lex Lowndes: Yeah.
Aymeric Obled: four or five like really as a team more than nowhere we have a huge cup with everyone doing different things and that I would like what I would like to change to is that I would like the leads and the POS to take decisions on their own because now it's a bit like we take the road map is coming from Batist okay next topic is this one is dispatch to one PO doing the specs and going to the text and I do think that yeah we have the road map that we need to follow.


00:24:14

Aymeric Obled: But there is a lot so a lot of things that if they work every day together, they could say like the lead and together like oh this page it could be nice to fix this because we have a lot of request about this or like you know to take more responsibilities and to feel that is their project and wanting to improve their project more than think that they part of a huge team where they just do the task arriving and
Lex Lowndes: Well, we I mean I absolutely think that you should do that slice it by sorry do do you slice it by application front end back end app or do you slice it by taxes, discounts, payment methods, PSPs, like choosing where that line is is difficult, but I think it's really important that we do something like that. Like have maybe maybe like a blenny team and um a back office team or or or something like that. Um
Aymeric Obled: What we did mobile features because we already did with this leads basically but we try to split like the big features we have and to put a team responsible of each topic for now then it's changing from one year to another one because depending on the road map maybe there is where we're not going to work at all on some topics so we need to align a bit to to say like a I mean you cannot have one card squad having 80% of the road map and the other


00:25:36

Aymeric Obled: 120. So we will have for sure to adapt stuff but at least to split bit like uh to know who is responsible of what and
Lex Lowndes: But that's but that's just it. They wouldn't have 80% of the road map. They'd have 100% of their own road map. So they don't So if if a team was responsible for um everything to do with let's say sales checkout and cart topups and products and sales keyboard let's say you just split that fifth like straight in the middle there. The road map then becomes whatever contributes towards those areas or applications and one team's road map might be longer but they would still have a road map. It's not um It's not
Aymeric Obled: There's always things to change and to improve in the end,
Lex Lowndes: that Yeah.
Aymeric Obled: even if it's a big line in the run.
Lex Lowndes: Yes. It's not like 80% of the work would go to one team and 20% would go to the other. They'd each have something to do forever in their own given areas provided that area was defined.


00:26:38

Lex Lowndes: Um the only question then comes is if you have two teams, they've both got their road maps and um one team needs like one team's area or domain has a lot of deadlines that they can't meet on their own, then you know that that needs more focus and attention. And maybe you need to either split what they own. like maybe then you either have a third team or you temporarily bring bring in the other team to work on part of it like that's
Aymeric Obled: Then you have to be smart and to adapt depending on what's happening.
Lex Lowndes: yeah but I think thinking about it in terms of like oh like one team would only have 20% of the work is is is slightly dangerous because it's sort of
Aymeric Obled: Okay.
Lex Lowndes: like it it just downplays what what they're what they're contributing when basically they're owning something and they're responsible for it. And it's still a lot of cognitive load and a lot of responsibility.
Aymeric Obled: No, you're right that it can be that we keep the scope by squad and then depending on if one team has a lot of deadlines or whatever, we see if the other team can come to help on some topics or stuff like this, but to not change the scops all the time, otherwise it's going to end up the same issue as we have right now.


00:27:56

Lex Lowndes: Yeah.
Aymeric Obled: But this was my goal to split in two squads. I know that David was saying like I don't want to assign a PO to a squad and for me I was like I do think that if you want to have a team we need to have one PO inside the squad like to really have them working together with the devs every day with the lead in the end if they are like a satellite outside is going to keep being like right now where we are going to have devs on one side P on the other side but I really think that we should have smaller teams smaller scopes and to fill them like then the PO and the the meeting they're doing on Tuesday to see who is going going to work on what. This should be like in each quad they just align. And if they have three devs, one PO, one lead, It's easier to know which topics they can take, what they can do more than when you have 10 people in the list and trying to guess and that they can choose and take responsibility like okay the next topic we want to take is this one.


00:28:51

Aymeric Obled: So let's prepare and
Lex Lowndes: Yeah, I would I would just start to in the nicest possible way ignore David. Um I
Aymeric Obled: David Batist was into splitting.
Lex Lowndes: as yeah
Aymeric Obled: But this was also into putting one PO in one K.
Lex Lowndes: I think just do it. Um at the end of the day David is going to be concerned with how quickly he is able to give you crazy ideas to implement in the deadlines that you hit and that's about it and are you causing him any headaches. the actual state of the team and how you operate should be largely determined by you.
Aymeric Obled: Mhm.
Lex Lowndes: Secondly, he might want there to not he might not want to put a PO in a team, but we he I don't think he can explain why.
Aymeric Obled: Mhm.
Lex Lowndes: Um and the third reason is that I said that one of the problems that we have with quality in this team um is a lack of uh training. It's not that um it's not that you don't care.


00:30:01

Lex Lowndes: It's not that you It's not even necessarily that you don't have time. I think you do have time. I think it's just that nobody really knows what they can do. And part of that come like that needs to come from leadership level. So that's David and and and Matia need to tell Baptist and you and Adrian and everyone underneath them how not prescribe what to do but to tell them what's important and then let them come to them with stuff.
Aymeric Obled: Mhm.
Lex Lowndes: So it exactly the same way as a product kickoff like don't come to the team with a a fully fleshed out thing and say you're doing this. Say this is what I want. However you get there is up to you.
Aymeric Obled: Mhm.
Lex Lowndes: And these are the things that are important. Like it's just the it's the exact same thing but scaled up. Um so yeah I his response is that he doesn't have the expertise to provide that training. So which I thought was you know really it was really good to have that level of calendar.


00:31:06

Lex Lowndes: Um, but it basically just means that wherever he asks you to do something, if you think it's a better idea, you're probably right.
Aymeric Obled: No, no, in the end we need to try like we cannot just stay like this and complain. We need to try things to see how we can help and maybe we are going to try things which are going to fail but at least you try we adapt we see what is better for the team and but the scope is huge like I mean when you see whisper in the beginning it doesn't look like huge but when you start really digging in the topic it's a ton of features and it's super difficult for everyone to 100% of the scope.
Lex Lowndes: Yeah,
Aymeric Obled: So yeah,
Lex Lowndes: definitely.
Aymeric Obled: we need to split. But I do think that this is the first thing we should do for the smaller scopes, the teams and things like this. And that then yeah, we can also change like to work more the team between devs, POS, and everyone like the acceptance criteria have more training because if your scope is smaller, it's easier to have training than to know what you're doing too.


00:32:07

Aymeric Obled: And yeah.
Lex Lowndes: You see you think the team split is the first step towards improvement and then from there the scope will give people a little bit more head space to be able to be trained up on these sorts of things and we can look at refining things as a team once the product people are actually in the team rather is separate from the T.
Aymeric Obled: Mhm. And for example,
Lex Lowndes: Okay.
Aymeric Obled: one issue I have and I know that batist is against this point but uh that for example now the two big topics they open is Android topics. I have three Android devs in a team of 10. So now I'm blocked like there are three devs. I don't have enough to do the Android topics we have right now because we open few huge Android topics but at the same time I have six or seven
Lex Lowndes: Uh-huh.
Aymeric Obled: days but I need to give them stuff so I cannot just let them like hey okay you do back end and front end so we have things to fix we have Gas we have stuff but then that's all we end up opening other topics because at the moment the devs are like hey I need things to do and for us as leads it's a lot of work when it's small topics because us we need to do specs we need to do review we need to do things so in the end it's also way more work on


00:33:16

Aymeric Obled: when he's opening a lot of small topics and in the end sometimes I'm like maybe you should be smarter in the way we open topics to try to have a mix about everyone having some work instead of just deciding we open two big Android topics and then we don't have the devs to do this at the same time and is complaining to not open topic but then I'm like well but what do I do with the six devs I have I mean I need to give them stuff too I cannot just I can give them tech topics and everything but I cannot do this for six months so
Lex Lowndes: You can you can One of them a QA
Aymeric Obled: Okay. And another thing is also that for example now we want we have one big topics which is migrating the way we use users in new way. So this is a big tech topics because it's migrating to have the same tools as the other apps and stuff like this. But we always end up because Ian started working on this to do like some discovery see what we need to do.


00:34:09

Aymeric Obled: But we always end up blocked by POS because at the moment you need to have some product decision but is going to say like hey we don't open a new topic because we have already the topics open. So then the topic is blocked and it's a bit like painful because going to complain like hey we need to prefer the next topics. POS are going to say like,"Hey, we don't return next topics because we have the current ones." And it's always like a bit uh
Lex Lowndes: Yeah, but I I think well, yeah, they need to certainly change the way they think up for preparing a topic because preparing a topic doesn't mean starting a topic. It just means doing discovery like m making it ready doesn't mean you're going to do
Aymeric Obled: Yeah. Yeah.
Lex Lowndes: it immediately once you've discovered it. And you should be constantly in a state of discovery doing discovery doing. Like you you discover something,
Aymeric Obled: Mhm.
Lex Lowndes: you do something, you discover something, you do something. And you just have two tracks in parallel which means you're always learning and you're looking about what's next.


00:35:09

Lex Lowndes: And you're al also at the same time doing the thing that you just discovered.
Aymeric Obled: Mhm.
Lex Lowndes: Um.
Aymeric Obled: Okay. No, but what I hope is that having smaller teams and having POS inside the team like that they manage
Lex Lowndes: Mhm.
Aymeric Obled: the next topics they want to take together like they have a team of three devs. They see what they can do in the next months or whatever. Okay, now we need to prepare back end topics because well we have devs who are going to be without anything like for them if they have a smaller scope I think they are going to be able to see what they have to prepare and everything too instead of just blindly prepare topics without knowing what we can take next and it's a lot of hope let's see if it's working or
Lex Lowndes: or or or rather than because they might struggle to think about what you can do front and back end the way you've got it here slice by sliced by feature group. So,
Aymeric Obled: Mhm.


00:36:06

Lex Lowndes: what what can we improve to do with reporting and analytics? And then you've got, you know, front end, back end, whatever. You got like a squad that's like looking at that side of things. What can we do with loyalty? A wallet like got ideas like run with that.
Aymeric Obled: Mhm.
Lex Lowndes: I'd be easier for product to get around that. And then you have like, you know, if you've got three devs per team, you know, you got a front, you got Android, you got a mobile. No, front front end front end front and back and mobile.
Aymeric Obled: from
Lex Lowndes: Um, so you've got like mix of skills or something
Aymeric Obled: it should be easier like this. turning.
Lex Lowndes: cuz that is one of the things that we struggled at at Kaboodle is we had front end team and a backend team and then whenever the front end needed an API like the communication between the teams wasn't very good and then they'd be sat there like blocked because they're waiting for the service
Aymeric Obled: I


00:37:08

Lex Lowndes: to be delivered, but the backend team weren't just sat there waiting for requests for new APIs or endpoints or whatever. They were doing third party integrations. They were doing um sort of like metrics, monitoring, alerting and all that sort of stuff. And they were also providing stuff for other teams. So it was really hard for them to sort of like maintain like a a good level of like doing delivering things and and unblocking at pace. So potentially having a mixed skill set team uh and
Aymeric Obled: Mhm.
Lex Lowndes: then and then limiting it by feature might be a good a good way to stop that from happening. But then you might have a feature that has no Android component and then that what what do you
Aymeric Obled: Mhm.
Lex Lowndes: do with that Android dev
Aymeric Obled: And in our teams mainly in we have a lot of full stack devs. So we are not much block with back end and front end. It's more for mobile because I think it's some expertise in mobile.


00:38:09

Aymeric Obled: No, we have Android devs like pure Android devs. So this but this we have a ton of Android topics in the world with event like team. So we are going to find things for them. But I think one other point is that well it's more bist which needs to change a bit but that doing discovery is not always opening a new topic because batist know is a bit like we are not going to start doing discovery on another topic because we are going to open another topic and in the end we need to start doing discovery way before opening the topic not because we are checking things and or we need to do things now but we need to take the topic in the next months like it can be later on but at least we need to prepare and to see how much time is going to take I don't know. That's
Lex Lowndes: Um I one of the things um I completely agree and I think that me uh me you Baptiste um maybe just us three I mean we could also include Marggo, Valentina, Adrian, and Tony in terms of like discussing this.


00:39:12

Lex Lowndes: And that's Yeah, cuz me, you and Baptiste wouldn't be a part of these teams.
Aymeric Obled: We have
Lex Lowndes: We'd we'd be separate and then it would be Margo's product team and Valentina's product team and then each of them would have Adrian and Tony. Um, and then they would be the actual teams. So it's whether or not you want to include those them in the discussion. It's probably a good idea to because it shows. Yeah, the six of us should get together um to discuss team split then maybe in the next couple of weeks.
Aymeric Obled: I already did use a tech. Well, this split we did with Tony and Adrian already. So on our side we already line and we saw that P more or less if you check they're already more either on Tony's topics or other topics. But yeah, I think we need to do like a meeting all together to choose. So we all line and no one is complaining. So but this I did with the lead.
Lex Lowndes: Yeah,


00:40:16

Aymeric Obled: I didn't do development on my own.
Lex Lowndes: it also means that Tony and Adrian can stop joining each other's meetings and Valentina and Margot go everywhere together. They could just do their squads meetings. Um, and then, you know, it's only really you and Baptist that go everywhere together. like go to everybody's meetings to maintain that overview but then
Aymeric Obled: Mhm.
Lex Lowndes: just give like instantly would just give them so much less to think about.
Aymeric Obled: If we do things well, we should have to kill the Tuesday's meet Tuesday's morning meeting where we decide who is going to do what. This should be inside each team. They align together to see what they do. But it should be a meeting with seven or eight persons.
Lex Lowndes: Yeah. I mean that you're going to start me off in a whole a whole thread here. Like I hate Confluence as a a thing to dis to organize and and plan things. Jira is the tool built for that for visualizing what work is where and who's working on it.


00:41:20

Lex Lowndes: And we just abandon it because it's so messy.
Aymeric Obled: My
Lex Lowndes: It's it's unorganized. it's un um like it's not updated in real time uh in a lot of instances and there's a lot of information on there that is pointless like we really only care about um what's ready for next sprint what's in the current sprint and how close is it getting to done like and we just can't do that so that's why they're using this confluence thing I really want to tidy up Jira um I've got a thing to follow up with Tony on that one
Aymeric Obled: And what we had is we had a flag to in JA to assign the task to a squad. The goal in the beginning was also that JA basically you can filter by squad. So on default squad they see their task. Well meaning if they want to see what's team doing they can. But to have a smaller board with only the team they have to see their task and stuff like this and to start organizing like this.


00:42:17

Aymeric Obled: But as I know it's like 10 or 11 people in the JA is of task but we need to clean and to have it organized.
Lex Lowndes: Yeah. Well, that once you decide on the team split, then I would create two fresh clean Jira boards and then I would go through the current one and I would move tickets to the relevant board like oh this is a your topic, this is your topic, this is your ticket, this is your ticket and do it that way and then from then build it out from there. Uh but probably abandon everything in backlog that is older than three months and then you start start from fresh.
Aymeric Obled: Mhm.
Lex Lowndes: Um
Aymeric Obled: But the good thing of the split is what we need to do as soon as that comes back. So we can start working on the next steps and stop postponing
Lex Lowndes: yeah,
Aymeric Obled: this.
Lex Lowndes: I think one of the So obviously that's big picture and I'm really glad that we're we're like super aligned on that. I think small small scale stuff.


00:43:24

Lex Lowndes: Some of the stuff you mentioned at the beginning is all stuff that came up with Adrian and Tony, which is that everybody's sort of got their own standards. It'd be really good to make sure that just as a small quick win, we just like make sure that everybody is testing her own work and that they attach I think it's really important to formalize using Jira.
Aymeric Obled: Mhm.
Lex Lowndes: So if you test something you don't message someone in Slack and tell them that you've tested it. You put it in Jira and then you say I've updated the Jira ticket for blah with a comment of what I've tested and then it's captured in there. Um there was a really really good example of this the other day. Just a second. Sorry. Ah, I can't say there was a good example and not have the example. Uh,
Aymeric Obled: And another thing I think what I'm trying to do more and more I know that I think it's more difficult for batist right now but us batis and myself to take more distance from the team to like to be present but to let them more autonomy and responsibility because if we keep being like taking everything topics on top I mean for me it's easier because I know that with I can let them think and I know that what they're going to do is nice but uh you know


00:45:24

Aymeric Obled: to really have them feeling that yeah they can come to ask what they think we can challenge the big topics we can do things but they can take decisions on their own and they don't need us to be checking like every spec they're writing everything like they have teams with them to check and to challenge themselves and this I think is a big part to for them to feel that they can take responsibilities and do things on their
Lex Lowndes: Yeah, definitely. Autonomy is is really big in terms of like scaling appropriately. Um, I've sent you a link to the thread. Basically me and Tony tested something and I said,"Hey, what would be a good idea is if you told Margot what you did and then when Margot needs to QA it, she's got a good idea of what's already been tested." Um, so he added he added a test report in Jira.
Aymeric Obled: Mhm.
Lex Lowndes: Um, I think if we could get everybody doing something like that and using that as an example, um, that would be really really good just in the short term because at least what you can do then is like if it's expected that that information should be there, then it's going to become really obvious when we know that people haven't done it.


00:46:41

Lex Lowndes: It's like,"Hey, where's the test report? I wouldn't test it." Well, f****** go and test it then or
Aymeric Obled: Uhhuh. No, that's nice. I never saw this as well.
Lex Lowndes: Yeah.
Aymeric Obled: At least you see that it's working as expected and
Lex Lowndes: Yeah. I think just that's that's a really small change because in theory they should be doing the testing anyway. The only difference to the process is right in the jury ticket in theory.
Aymeric Obled: yeah, it's a good point. And this is easy thing to easy things to add then it's a good idea
Lex Lowndes: Um, and you what was the sorry, what was the last thing you that you said before we started talking about the the ticket the
Aymeric Obled: that we need to give I think even more in the product parts in the POS and in the tech team but that we need to let them autonomy and that they need to think and to believe that they can do things without asking batist every time they write something if it's okay or not like you know to feel like okay yeah I can come it's nice to come to validate some specs but no I feel they're waiting a lot for batist to do the last version and that is blocking a lot of things and that's also why we are so slow on the specs and stuff like


00:48:06

Lex Lowndes: when yeah that's I don't the the the the concept of specs is is is odd to to me. So you AJ and Tony write the specs for the rest of the developers but the developer so it like
Aymeric Obled: depends on the devs. Some devs we just do the kick off to show them and they write more most of the time we try not to have the devs writing their own specs like to show them but they write the specs and that then we validate the specs with them but we try to have more and more the devs writing their own specs then we validate and then we do or that they do the specs for another dev but
Lex Lowndes: Okay.
Aymeric Obled: uh especially well just for this reason that we don't want the dev to just receive task and code and that it's nice for them to do specs and to I mean it's another thing that you need to as a dev I think and to write for other ones or for yourself and to be able to do estimation so to think before what you're going to do and this is something we try to do more and


00:49:10

Lex Lowndes: That part I agree with. I think don't just get a story and start coding.
Aymeric Obled: Okay.
Lex Lowndes: It definitely it but I think I think the the it was the separation of the process. It was a story gets written, a spec gets spawned, and then the spec spawns tasks, but it's not necessarily like one continuous thing. Like a story and a spec should basically be drawn up more or less together like during a refinement like typically in in the way that I'm used to working like they're they're created together and then the subtasks are created before the work starts as well. like it's all sort of like done in one well not necessarily one over a series of pre-sprint meetings but it but it's
Aymeric Obled: Mhm.
Lex Lowndes: not it feels very much like passing the baton to the next person like a relay race like no one's really like developers aren't if if a developer just gets given a story and then is told to write specs but they weren't necessarily involved in the story writing process and then the person who wrote the story isn't involved in the spec writing process.


00:50:21

Lex Lowndes: Like it's not super collaborative. So just I think again this comes down to sort of like how do we reimagine these kickoffs I think. Um but at the same time I don't I don't I don't want to change too many things in one go because it's going to be really hard.
Aymeric Obled: But then we are going to do step by step already. If we start doing the split having smaller team that they feel that they work together and stuff like this then we can accomplish new changes and improvements to do and That's another point. Well, if we are done with this because we had the discussion yesterday about the Android testing.
Lex Lowndes: Oh yeah, that's that you can't you can't leave me with three minutes left on the meeting and throw that bring that back up.
Aymeric Obled: No, no,
Lex Lowndes: What?
Aymeric Obled: but because that's we know we don't have any testing in the clear Android app. So this is a nightmare because every time you cut something, you don't know if you broke something else. So that's why it's super painful.


00:51:26

Aymeric Obled: We have to do a ton of manual QA to check that it's working and everything. The thing for the new as you're redoing the wall app, no, we say like at least all the logic could be tested that if you have filters, if you have things that to ensure that no one can break this without breaking the test, but I do think that well I'm not super fan of testing the UI in itself like checking that the button is here. But I do think that we should have the full flow testing like is the payment flow working that uh you click on the card button while you click on the pay button is displaying the payment method. If you click on this cash is it opening the cash flow like
Lex Lowndes: It's so there's I think there's a much larger level of granularity that exists between something that is like a an invocation handler like has button been pressed yes great that's like one bit and then a payment flow is like this the is an an end to end test I think there are unit and integration tests that exist in between there that we should absolutely be doing so it's it's when it I think the thing that's that scared me So much about the statement was no unit tests to do with front end is that it's the example that Pavle gave you was a bad example.


00:52:45

Lex Lowndes: It's it's almost like a bit of a straw man. It's it's a it is a trivial thing that he said button works when pressed. That's not what the test should be doing. The but the test should be more to do with the behavior. So if button is pressed and these values are set, it rejects it. or if button is pressed and these values aren't set then it's uh status is disabled or whatever like it's that level of unit test is still really really valuable because you're you're testing the behavior not the component. I don't care if the framework is is is is there but it's about having those behavior level tests
Aymeric Obled: Mhm.
Lex Lowndes: at that stage and not being relying on them being caught at the logic level for example because there's there is an element of logic baked into those front-end components.
Aymeric Obled: Yeah, I get your point. Yeah. Not really testing like a is a button this size, but like more like, hey, if I click in this button, is it doing something or is it filtering correctly or is it


00:53:47

Lex Lowndes: Yeah. Or even something like a like a page render. So if I if I have a mock payload of this basket summary, these are the elements that are displayed and these are the values that are in them.
Aymeric Obled: Mhm.
Lex Lowndes: Um, and then you can go,"Oh, hang on a minute. That we're not displaying the price whenever we show uh burgers or something like there's like some sort of weird thing there." Like that that level of UI unit test is probably still is probably still really important. Um, which why?
Aymeric Obled: And this is something you should define before coding what you want to test and which test you want to.
Lex Lowndes: Yes, that's why it's more it's not I think what Pavle was saying is I don't know how to come up with a good test rather than I don't think we should test because I think he wants he wants to write tests but he doesn't want to write s***
Aymeric Obled: Hello.
Lex Lowndes: tests.
Aymeric Obled: Hello.
Lex Lowndes: So I think we rather than going okay don't test I think we need to push for okay well this is a good opportunity to have that discussion what do we actually want to test what are you working on like and then also not just saying oh yeah you should test this but I like sort of like doing enough coaching with him to so the next time that question comes up he's he can come up with that himself like give him the tools to be able to determine what is and isn't a good test.


00:55:17

Aymeric Obled: Mhm. It can be a good test for the next one. Especially know that you have Paula working on a brand new feature. It's perfect example to add useful test.
Lex Lowndes: I think it's uh I think it's also really fun as well like Blenny V2 which amazing like what what what we're doing with that like It's It's a really good time to iron like we're we're trying to iron out a lot of tech debt from V1, right?
Aymeric Obled: Mhm.
Lex Lowndes: Like it's a really good time to understand what each different bit does. If we're just transcribing it from V1 to V2 and then maybe cleaning up the code a little bit, but we don't understand it, we're going to be making Blenny V3 next year.
Aymeric Obled: Mhm. Yeah.
Lex Lowndes: Like like we should write we should be writing tests and understanding it. Like now is the time to understand what we want V2 to to do and to be. And tests tests are the way to do that because it forces us to understand what it is that we're actually building.


00:56:20

Aymeric Obled: Mhm. Now we need to check on this. Okay. Now we have time, new features, brand new cut. So is a perfect one. So got this. Okay. Nice.
Lex Lowndes: Cool. All right. Well, I will put together a bit of a a plan and then when you're back, we'll all get together. We'll talk about team split. If you could put together a small something about the test report, so when you test, put it in Jer, that'd be awesome. Um,
Aymeric Obled: Mhm.
Lex Lowndes: and then I'll um I'll speak to Margo and Valentina as well. Like in the future, you should expect to see this. And then if you don't if you don't get it,
Aymeric Obled: Mhm.
Lex Lowndes: you're well within your rights to tell the tell the dev you need to put this so that they're not letting it slip through the cracks as well cuz you can't check it all. Um
Aymeric Obled: I take this but then let's meet next week with let's see if you meet with everyone with batties but to align on the split of the teams and stuff like this to stop taking action
Lex Lowndes: yeah, defin Yeah,
Aymeric Obled: quite quick and not to postpone for one or two more months.
Lex Lowndes: definitely.
Aymeric Obled: Okay, nice
Lex Lowndes: Cool. Okay. Um if if if if I don't if I don't get the meeting notes, um could you just send Yeah, just send them over to me.
Aymeric Obled: to see you.
Lex Lowndes: That might be awesome. Okay, cool. See you later.
Aymeric Obled: Have a nice day.
Lex Lowndes: You see?
Aymeric Obled: Bye.
Lex Lowndes: Bye.


Transcription ended after 00:57:54

This editable transcript was computer generated and might contain errors. People can also change the text after it was created.
