import Foundation

enum ContentData {
    static let entrances: [PrepItem] = [
        PrepItem(id:"entrance-noface", title:"No-Face on Stilts", summary:"Enter as No-Face from Spirited Away on stilts and stay completely in character.", details:"OPENING\n\nDress as No-Face from Spirited Away and use stilts to create an unnaturally tall silhouette. Enter slowly and silently. Do not explain the costume or immediately break character. Move strangely, stare, linger, and interact with Bell and chat through body language rather than normal conversation. Let their reactions determine what happens next.\n\nThe comedy is the commitment: be weird, quiet, and fully in character. Do not chase a prepared punchline. Once the scene naturally peaks, either leave just as strangely as you arrived or let the character break only if the live interaction gives you a better direction. Use stilts only in a clear, practiced area with a spotter and no sudden movements near anyone.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-scare", title:"Surprise Scare", summary:"Have Jieuny or Matt pull Bell out, hide, then surprise her when she returns.", details:"OPENING\n\nGet Jieuny or Matt to pull Bell out of her room for a minute while I hide in Matt’s room. Once Bell is out, slip into her room and hide behind/near the door. When she comes back, surprise/scare her as the opening beat.\n\nKeep the setup simple: the scare is the planned premise, not a scripted conversation afterward. Once she reacts, drop the plan and respond to whatever she actually gives me. No physical contact; make sure Matt/Jieuny are okay with the room setup beforehand.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-doctor", title:"Doctor Examination", summary:"Stethoscope + clipboard. Examine Bell without explanation.", details:"Walk in with stethoscope, coat/clipboard. Examine Bell without explanation. Check pulse: “Low pulse. That checks out. She’s barely moving.” If Bell argues, write on clipboard: “Patient remains combative.” Running callback: “I’ve received the lab results.”", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-nature", title:"Nature Documentary", summary:"Narrate Bell like wildlife in her natural habitat.", details:"Enter quietly while narrating Bell like a wildlife documentary. “Here we see the streamer in her natural habitat…” If Bell notices you: “She’s spotted us.” React to whatever she does as animal behavior. Can return later, still documenting her.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-crime", title:"Crime Scene Investigation", summary:"Gloves + harmless UV light. Discover increasingly concerning ‘evidence.’", details:"Enter with gloves + harmless UV/blacklight flashlight. Silently inspect random areas. Find something → concerned expression → look at Bell. “I’m going to need everyone to remain calm.” Find another → “Jesus Christ.” If Bell asks what you found: “I’m legally not allowed to answer that.” Can return later with increasingly serious ‘evidence.’", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-tea", title:"Geisha-Inspired Tea Service", summary:"Formal theatrical tea service. Explain nothing.", details:"Enter in a theatrical outfit carrying tea. Say almost nothing. Very formally prepare/pour Bell tea. Bow. Immediately leave. Keep returning throughout the stream to perform increasingly strange unexplained services. Never explain why you’re doing it.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-awards", title:"Awards Ceremony", summary:"Present a cheap trophy for a ridiculous achievement.", details:"Enter formally carrying a cheap trophy. Give an excessively serious presentation. “For outstanding achievement in consecutive hours streamed without touching grass…” Present Bell with trophy. Formal handshake/photo. Leave trophy visible. Later return with increasingly ridiculous awards.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-replacement", title:"The Replacement", summary:"Enter dressed Bell-adjacent and take over as host.", details:"Enter wearing a Bell-style hoodie or similar outfit. Sit down and start addressing chat as though you’re Bell. If Bell objects: “Bell, please. You’re interrupting the stream.” Treat actual Bell like an unwanted guest/replacement streamer. If using something of hers, get permission beforehand.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-handcuff", title:"Handcuff Catastrophe", summary:"Megaphone + cuffs + chocolate key. Realize you’re ‘stuck.’", details:"Enter with megaphone + handcuff prop. Ceremoniously ‘swallow’ a chocolate/prop key. Slowly realize the consequences. Look at Bell. Look at chat. “…I may not have thought this through.” Attempt increasingly ridiculous solutions. Keep the actual release key immediately accessible.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-wrongroom", title:"Wrong Room", summary:"Walk in, see Bell, say ‘Oh fuck,’ leave, then return normally.", details:"Walk in normally. See Bell. Freeze. “Oh fuck.” Immediately leave. Return 10–20 seconds later. Act like absolutely nothing happened.", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-late", title:"Extremely Late", summary:"Rush in apologizing for being late to something you weren’t invited to.", details:"Rush into the room looking panicked. “I’m so fucking sorry I’m late.” If Bell says, “You weren’t supposed to be here,” pause, look at chat: “This is worse than I thought.”", group:"Entrance", badge:nil),
        PrepItem(id:"entrance-faceplant", title:"Full Face-Plant", summary:"Walk straight to the bed and face-plant without explanation.", details:"Enter normally. Don’t announce anything. Walk directly to bed. Full face-plant. Remain completely motionless slightly longer than comfortable. Let Bell/chat create the interaction.", group:"Entrance", badge:nil)
    ]

    static let games: [PrepItem] = [
        PrepItem(id:"game-court", title:"Bad Improv Court", summary:"Absurd crime → prosecute vs defend → chat jury.", details:"Chat submits an absurd fictional crime. One person prosecutes; one defends. Invent evidence, witnesses, motives and alibis. Respond to each other’s arguments in real time. Chat votes GUILTY / NOT GUILTY. Example: Bell microwaved fish in a workplace break room.", group:"Top 5", badge:"TOP 5"),
        PrepItem(id:"game-defense", title:"Five-Second Defense", summary:"Chat accusation → 5 seconds to start a defense → interrogation.", details:"Chat gives Bell or me a ridiculous accusation. The accused gets five seconds to begin their defense. The other person interrogates. Chat decides whether the defense worked.", group:"Top 5", badge:"TOP 5"),
        PrepItem(id:"game-oneword", title:"One-Word Story", summary:"Tell a story one word at a time.", details:"Bell and I tell a story one word at a time. Neither controls where it goes. Optional: chat periodically supplies a mandatory word that must appear.", group:"Top 5", badge:"TOP 5"),
        PrepItem(id:"game-worse", title:"Make It Worse", summary:"Take a bad situation and escalate it turn by turn.", details:"Chat gives a bad situation. Bell makes it worse. I make Bell’s version worse. Alternate until a minor inconvenience becomes an unimaginable catastrophe.", group:"Top 5", badge:"TOP 5"),
        PrepItem(id:"game-explain", title:"Explain Yourself", summary:"Bizarre situation → explain it without contradicting yourself.", details:"Chat gives one person a bizarre situation they’ve supposedly been caught in. The accused explains it; the other interrogates. Every answer becomes established fact and cannot be contradicted. Chat votes BELIEVABLE / BULLSHIT.", group:"Top 5", badge:"TOP 5"),
        PrepItem(id:"game-ranking", title:"Ranking Court", summary:"Build a tier list; disputed placements must be defended.", details:"Chat supplies a category. Bell and I build a tier list. Every disputed placement must be defended. If we can’t agree, chat decides the final placement.", group:"Other", badge:nil),
        PrepItem(id:"game-secret", title:"Secret Objective", summary:"Hidden missions run in the background of normal conversation.", details:"Bell and I secretly receive different missions. Chat knows them; we don’t know each other’s. Examples: get Bell to say a word, get me to mention Skyrim, get the other person to stand up, ask a specific question, or believe something ridiculous.", group:"Other", badge:nil),
        PrepItem(id:"game-indefensible", title:"Defend the Indefensible", summary:"Defend an obviously terrible position under cross-examination.", details:"Chat gives an obviously terrible position. One person must defend it; the other cross-examines. You cannot abandon the argument. Chat decides whether it was successfully defended.", group:"Other", badge:nil),
        PrepItem(id:"game-sharktank", title:"Terrible Shark Tank", summary:"Pitch a useless product as revolutionary.", details:"Chat invents a useless product. One person pitches it; the other becomes the investor and interrogates. Then switch. Chat votes INVEST / PASS.", group:"Other", badge:nil),
        PrepItem(id:"game-expert", title:"Fake Expert", summary:"Become the world’s leading expert on a subject you know nothing about.", details:"Chat chooses a subject. One person becomes the world’s leading expert and cannot admit ignorance. The other conducts a completely serious interview. Chat can submit questions.", group:"Other", badge:nil),
        PrepItem(id:"game-fortunate", title:"Fortunately / Unfortunately", summary:"Alternate story beats beginning Fortunately / Unfortunately.", details:"Chat gives the opening sentence. Bell continues with ‘Fortunately…’ and I continue with ‘Unfortunately…’ then alternate. Every statement must accept what the previous person established.", group:"Other", badge:nil),
        PrepItem(id:"game-yesand", title:"Yes-And Escalation", summary:"Accept every premise and keep heightening the same reality.", details:"Chat gives an ordinary starting situation. Each person accepts what the previous person established and adds something new. Nobody can erase or reject the premise. Escalate until absurd.", group:"Other", badge:nil),
        PrepItem(id:"game-switch", title:"Character Switch", summary:"Improvise a scene; chat calls SWITCH and you exchange characters.", details:"Chat gives location + two characters. Begin the scene. At any point chat can type SWITCH. Bell and I immediately exchange characters and continue the same scene.", group:"Other", badge:nil),
        PrepItem(id:"game-emotion", title:"Emotional Whiplash", summary:"Chat changes the emotion of an ongoing conversation.", details:"Bell and I begin a normal conversation. Chat calls emotions like ANGRY, PARANOID, TERRIFIED, OVERCONFIDENT, DEVASTATED, SUSPICIOUS, ECSTATIC. Continue the same conversation in the new emotion.", group:"Other", badge:nil),
        PrepItem(id:"game-conspiracy", title:"Conspiracy Generator", summary:"Turn an ordinary thing into an enormous conspiracy.", details:"Chat gives something ordinary. One person invents the conspiracy; the other provides evidence; keep layering until mundane becomes enormous.", group:"Other", badge:nil),
        PrepItem(id:"game-scene", title:"Five-Second Scene", summary:"Location + relationship → begin scene in five seconds.", details:"Chat gives LOCATION + RELATIONSHIP. Examples: funeral — rival magicians; DMV — divorced superheroes; spaceship — incompetent astronauts; restaurant — undercover detectives. Five seconds to begin. No planning.", group:"Other", badge:nil)
    ]

    static let topics: [PrepItem] = makeTopics()
    static let exits: [PrepItem] = makeExits()

    // Mid Stream ships empty on purpose: it's the bucket for the user's own
    // ideas that happen during the stream and fit none of the other types.
    static let mids: [PrepItem] = []

    static func items(for section: PrepSection) -> [PrepItem] {
        switch section {
        case .entrance: return entrances
        case .topic: return topics
        case .game: return games
        case .mid: return mids
        case .exit: return exits
        }
    }

    static func section(ofItemID id: String) -> PrepSection? {
        PrepSection.allCases.first { section in
            items(for: section).contains { $0.id == id }
        }
    }

    private static func t(_ id:String,_ title:String,_ q:String,_ group:String) -> PrepItem {
        PrepItem(id:id,title:title,summary:q,details:q,group:group,badge:nil)
    }

    private static func makeTopics() -> [PrepItem] {
        var a:[PrepItem] = []
        let lore = [
            "What opinion do you have that chat absolutely hates?", "What’s something chat will never let you live down?", "What’s the dumbest argument you’ve ever had with chat?", "What’s the most unhinged thing someone’s said in chat?", "Which chatter would you trust with your life? Least?", "What’s something chat thinks they know about you but gets completely wrong?", "What’s a stream moment you wish you could erase from the internet?", "What’s something you’ve done on stream that seemed completely normal until chat reacted?", "What’s your favorite running joke from the stream?", "What’s a joke chat needs to finally retire?", "Who in chat gives you the most shit?", "What’s the hardest chat has ever made you laugh?", "What’s the most unexpectedly wholesome thing that’s happened on stream?", "What stream moment would you show someone who’s never watched you before?", "What would chat say is your worst habit?", "What’s something you refuse to do on stream again?", "What’s your most embarrassing clip?", "What’s the strangest thing streaming has taught you about people?"
        ]
        for (i,q) in lore.enumerated(){ a.append(t("topic-lore-\(i)","Bell / Stream Lore",q,"Bell / Stream Lore")) }
        let chat = ["Chat, what’s Bell’s worst habit?","What does Bell consistently lie to herself about?","What’s Bell weirdly good at?","What’s Bell confidently terrible at?","What’s something Bell does every stream without realizing it?","What phrase does Bell say constantly?","What’s the most Bell thing Bell has ever done?","What’s her most irrational opinion?","What’s something you’ve been trying to convince Bell to do forever?","If Bell were an NPC, what’s her one repeated dialogue line?","What’s Bell’s biggest rage-quit moment?","Give me one piece of Bell lore I don’t know.","What’s something I should absolutely never ask Bell about?"]
        for (i,q) in chat.enumerated(){ a.append(t("topic-chat-\(i)","Direct to Chat",q,"Direct to Chat")) }
        let gamesQ = ["What game would you erase from your memory just to experience it for the first time again?","What’s your most embarrassing gaming rage?","What game are you objectively terrible at but still love?","What’s a game everyone loves that you can’t stand?","What game deserves a sequel and will probably never get one?","Which game character would be absolutely unbearable in real life?","What game world would you actually live in?","What game world would you die in within five minutes?","What’s the first game you remember being obsessed with?","What boss made you question your life choices?","What’s something you always do in games even when there’s no reason to?","If chat controlled your character for an hour, what would happen?"]
        for (i,q) in gamesQ.enumerated(){ a.append(t("topic-games-\(i)","Video Games",q,"Video Games")) }
        let food = ["What’s a food opinion that would get you banned from your own chat?","What’s an expensive food that’s completely overrated?","What’s a cheap food you’d defend with your life?","What’s a food everybody loves that you hate?","What’s the weirdest food combination you genuinely enjoy?","What’s something you thought was disgusting as a kid and love now?","What’s your death-row meal?","What’s the worst thing you’ve ever cooked?","What restaurant could you eat at every week?","What’s a food you’ll never understand the hype around?","What’s the most disappointing meal you’ve ever paid too much for?","What’s the one food you could never give up?"]
        for (i,q) in food.enumerated(){ a.append(t("topic-food-\(i)","Food",q,"Food")) }
        let media = ["What’s a movie everyone calls amazing that you think sucks?","What’s your comfort movie?","What’s a terrible movie you secretly love?","What show had the worst ending?","What character did everyone love that you hated?","What villain did you secretly agree with?","What fictional character are you most similar to?","What character would you absolutely date despite knowing it’s a terrible idea?","What show do you wish you could watch for the first time again?","What series did you abandon halfway through?","What anime would you recommend to someone who hates anime?","What’s the most overrated anime?","Which anime character would be the worst roommate?","Which fictional universe would you actually want to live in?","What’s something you watched solely because everyone kept telling you to?","What show have you rewatched an embarrassing number of times?"]
        for (i,q) in media.enumerated(){ a.append(t("topic-media-\(i)","Movies / TV / Anime",q,"Movies / TV / Anime")) }
        let personality = ["What’s something you’re irrationally competitive about?","What’s a completely useless skill you’re proud of?","What’s something you believed for way too long as a kid?","What’s the dumbest way you’ve ever injured yourself?","What’s the strangest compliment you’ve ever received?","What’s a tiny thing that instantly annoys you?","What’s something you’re embarrassingly bad at?","What’s a hill you’ll die on that absolutely doesn’t matter?","What’s the worst purchase you’ve ever made?","What’s something you bought that you absolutely didn’t need?","What’s the weirdest phase you’ve ever gone through?","What’s a completely mundane thing you’re weirdly particular about?","What’s something you thought you’d be good at and immediately discovered you weren’t?","What’s the funniest misunderstanding you’ve ever been involved in?","What’s a talent you wish you had?","What mundane thing makes you disproportionately happy?"]
        for (i,q) in personality.enumerated(){ a.append(t("topic-personality-\(i)","Personality / Stories",q,"Personality / Stories")) }
        let tease = ["What’s your biggest red flag?","What would your friends say is your most annoying trait?","What are you convinced you’re good at that nobody else agrees with?","What would you absolutely lose a competition against me at?","What could a five-year-old probably beat you at?","What’s something you judge people for immediately?","What’s your pettiest dealbreaker?","What’s the longest you’ve held a completely pointless grudge?","What’s something you pretend not to care about but obviously care about?","What’s the dumbest thing you’ve ever been stubborn about?"]
        for (i,q) in tease.enumerated(){ a.append(t("topic-tease-\(i)","Natural Teasing",q,"Natural Teasing")) }
        return a
    }

    private static func makeExits() -> [PrepItem] {
        return [
            PrepItem(id:"exit-2",title:"Sincere → Immediate Takeback",summary:"Good time → never again",details:"""
IDEA
Have a genuinely warm goodbye, then immediately undercut it.

EXAMPLE DELIVERY
“Alright, I had a really good time with you tonight.”

Start leaving.

“Obviously, I won’t be making that mistake again.”
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-3",title:"Simple Warm Ending",summary:"Love chat → reluctant Bell affection",details:"""
IDEA
Say a warm goodbye to chat, then include Bell almost reluctantly.

EXAMPLE DELIVERY
“Alright, I’m out. Love you guys.”

Look at Bell. Pause.

“…You too, I guess.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-4",title:"Actually Follow Through",summary:"Say something nice → mean it",details:"""
IDEA
Set up a reluctant compliment, then actually give Bell a sincere one.

EXAMPLE DELIVERY
“Before I leave, I feel like I should say something nice about Bell.”

Pause.

“You make this really fun.”

Leave before she can make it weird.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-5",title:"Sincere → Protect the Reputation",summary:"Enjoyed tonight → don’t clip it",details:"""
IDEA
Admit you genuinely enjoyed yourself, then immediately protect your reputation.

EXAMPLE DELIVERY
“I actually really enjoyed tonight.”

Look at chat.

“Nobody fucking clip that.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-6",title:"Unexpectedly Sweet",summary:"Thanks → playful Bell tease",details:"""
IDEA
Thank everyone sincerely, then give Bell a light tease on the way out.

EXAMPLE DELIVERY
“Alright, I’m heading out. Thanks for letting me hang out with you guys.”

Look at Bell.

“And you weren’t completely unbearable tonight.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-8",title:"Give Bell Credit",summary:"Compliment Bell → surprised by it",details:"""
IDEA
Give Bell real credit, then undercut your own willingness to admit it.

EXAMPLE DELIVERY
“You were actually really funny tonight.”

Pause.

“I’m as surprised as you are.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-10",title:"Reluctant Compliment",summary:"Promise something nice → abort",details:"""
IDEA
Announce that you should say something nice, then fail to produce the compliment.

EXAMPLE DELIVERY
“Before I leave, I feel like I should say something nice about Bell.”

Long pause. Look at Bell. Look at chat.

“Thanks everybody. Goodnight.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-12",title:"Compliment Through Chat",summary:"Return Bell to chat → supervision",details:"""
IDEA
Put chat back in charge of Bell and frame it like a responsibility.

EXAMPLE DELIVERY
“Chat, take care of her for me.”

Look at Bell.

“She requires constant supervision.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-15",title:"Overstate the Relationship",summary:"One of the evenings we’ve ever spent",details:"""
IDEA
Give a grand relationship-closing sentence that technically says almost nothing.

EXAMPLE DELIVERY
“Alright, Bell.”

Offer handshake.

“This has been one of the evenings we’ve ever spent together.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-16",title:"Reverse Stonewall",summary:"Tiny goodbye → treat it like betrayal",details:"""
IDEA
If Bell gives you a flat goodbye, react as if she dismissed an entire shared history.

EXAMPLE DELIVERY
Bell: “Bye.”

Stop at the doorway. Look back at her.

“After everything we’ve been through tonight…”

Pause.

“‘Bye.’”

Look at chat. “Incredible.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-17",title:"The Concerned Friend",summary:"Offer help → reveal exact effort limit",details:"""
IDEA
Offer one last act of concern, then reveal how little effort you were actually willing to spend.

EXAMPLE DELIVERY
“Do you need anything before I leave?”

Bell: “No.”

“Perfect. That’s exactly how much I was willing to do.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-21",title:"Give Chat the Last Word",summary:"Chat chooses final sentence",details:"""
IDEA
Let chat write your final line, then commit to it completely.

EXAMPLE DELIVERY
“Chat, give me one sentence to say to Bell before I leave.”

Read submissions. Pick one. Turn toward Bell. Say it completely seriously. Immediately leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-7",title:"Chat Appreciation",summary:"Appreciate chat → small Bell tease",details:"""
IDEA
Thank chat genuinely for making the night fun, then give Bell a small playful acknowledgment.

EXAMPLE DELIVERY
“Seriously, chat, you guys were fun tonight. Thanks for letting me invade your stream.”

Look at Bell.

“And thanks for providing the building.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-9",title:"Pure Sincerity",summary:"Genuine goodbye → no joke needed",details:"""
IDEA
End sincerely. Do not protect the moment with a joke unless one naturally appears.

EXAMPLE DELIVERY
“Seriously, thanks for having me. I had a good time.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-13",title:"Review Bell",summary:"Rate Bell/night → defend the score",details:"""
IDEA
Give Bell an arbitrary rating for the night and defend it if she challenges you.

EXAMPLE DELIVERY
“Overall performance tonight…”

Think seriously.

“Seven and a half.”

If challenged: “That’s actually extremely high for you.”
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-14",title:"Leave Bell With a Mission",summary:"Mission: DO NOT RAGE QUIT",details:"""
IDEA
Give Bell one final responsibility before leaving: do not rage quit. Phrase it based on what happened that night.

EXAMPLE DELIVERY
“Bell, I’m leaving you with one responsibility.”

Pause.

“Do not rage quit.”

Leave.
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-18",title:"Performance Review — Bell",summary:"Chat reviews Bell → you give verdict",details:"""
IDEA
Ask chat to evaluate Bell, read a few answers, then issue your own final ruling.

EXAMPLE DELIVERY
“Chat, before I leave, we need Bell’s final performance evaluation.”

Read a few responses.

“Alright. The panel has spoken. I’ll allow her to continue streaming.”
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-19",title:"Performance Review — Me",summary:"Chat reviews you → react to verdict",details:"""
IDEA
Ask chat how you did and let their answers create your final response.

EXAMPLE DELIVERY
“Before I leave—chat, how did I do tonight?”

If positive: “Finally, an unbiased panel of experts.”

If negative: “This election was clearly compromised.”
""",group:"Exit",badge:nil),
            PrepItem(id:"exit-20",title:"Pretend You’re Holding Back Emotion",summary:"Emotional goodbye → natural undercut",details:"""
IDEA
Treat leaving like an emotionally difficult goodbye. Let Bell’s response determine how you break the emotion.

EXAMPLE DELIVERY
“Alright guys, I’m gonna go.”

Look around dramatically.

“I’m not good at goodbyes.”

If Bell says something dismissive: “Please. You’re making this significantly easier.”
""",group:"Exit",badge:nil)
        ]
    }
}
