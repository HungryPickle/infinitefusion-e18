=begin
*** Wonder Trade Script by Black Eternity ***
This script is to mimic Wonder Trade from an offline perspective.
THERE IS NO ONLINE CAPABILITIES OF THIS SCRIPT,
ALL CALCULATIONS ARE DONE INTERNALLY.

To call the script like normal and have ALL Pokemon trade-able, use the following.
    pbWondertrade(1,[],[])

Black listed Pokemon are to be added to the Exceptions arrays.
  Except is the list of pokemon the player is forbidden to trade.
    Here the player cannot trade any of the following.
      pbWonderTrade(1,[:PIKACHU,:SQUIRTLE,:CHARMANDER,;BULBASAUR],[])

  Except2 is the list of pokemon the player is forbidden to receive.
    Here the player cannot receive any of the following.
      pbWonderTrade(1,[],[:MEWTWO,;MEW,;DEOXYS])



The first parameter is the minimum allowed Level of the Pokemon to be traded.
For example, you can not trade a Pokemon through Wonder Trade unless its level
is greater than or equal to specified level.

    pbWonderTrade(40,[:SQUIRTLE,:CHARMANDER,:BULBASAUR],[:MEWTWO,:MEW,:DEOXYS])
    *** Only pokemon over level 40 can be traded, you cannot trade starters.
    *** You cannot receive these legendaries.

The fourth parameter, which has recently replaced mej71's "hardobtain"
is called "rare", this parameter developed also by mej71, will use
the Pokemon's rareness and filter the results depending on its values.

** Rareness is turned on by default, if you wish to disable it, call the
    function accordingly.

    pbWonderTrade(10,[:SQUIRTLE],[:CHARMANDER,:BULBASAUR],false)
    ** Only Pokemon over level 10, cannot trade Squirtle, cannot
    ** recieve Charmander or Bulbasaur, Rareness disabled.

It is up to you to use it how you wish, credits will be appreciated.
=end

# List of Randomly selected Trainer Names
# These are just names taken from a generator, add custom or change to
# whatever you desire.

RandTrainerNames_male = [
  "Mikaël",
  "James",
  "Keith",
  "Matthew",
  "Jeremy",
  "Louis",
  "Albert",
  "Aaron",
  "Francis",
  "Steve",
  "Jeffrey",
  "David",
  "Henry",
  "Christopher",
  "Ronald",
  "Randy",
  "William",
  "Ash",
  "Jesse",
  "Roger",
  "Todd",
  "Fred",
  "Scott",
  "Phillip",
  "Craig",
  "Mildred",
  "Douglas",
  "Ernest",
  "Brandon",
  "Jean",
  "Stan",
  "Kenny",
  "Eric",
  "Kyle",
  "Raymond",
  "Harry",
  "Gary",
  "Bill",
  "Howard",
  "Stephen",
  "Russell",
  "Bobby",
  "Martin",
  "Harold",
  "Juan",
  "Joseph",
  "Charles",
  "Donald",
  "Arthur",
  "Janice",
  "Carlos",
  "Jack",
  "Ralph",
  "Barrack",
  "Kevin",
  "James",
  "Michael",
  "Boris",
  "Vladimir"
]

RandTrainerNames_female = [
  "Emily",
  "France",
  "Joan",
  "Dorothy",
  "Alice",
  "Sara",
  "Anne",
  "Shirley",
  "Carolyn",
  "Christina",
  "Nancy",
  "Virginia",
  "Donna",
  "Jacqueline",
  "Catherine",
  "Jesse",
  "Denise",
  "Ashley",
  "Maria",
  "Helen",
  "Teresa",
  "Annie",
  "Rachel",
  "Kathleen",
  "Marie",
  "Diane",
  "Beverly",
  "Lisa",
  "Lois",
  "Deborah",
  "Bianca",
  "Phyllis",
  "Melissa",
  "Laura",
  "Lara",
  "Stephanie",
  "Evelyn",
  "Irene",
  "Jean",
  "Sandra",
  "Linda",
  "Lucy",
  "Molly",
  "Kathryn",
  "Katherine",
  "Theresa",
  "Louisel",
  "Alyssa",
  "Susan",
  "Andrea",
  "Sharon",
  "Rose",
  "Lori",
  "Doris",
  "Joseph",
  "Janice",
  "Wanda",
  "Christine",
  "Mel",
  "Betty",
  "Julia",
  "Michelle",
  "Kathy"
]

RandTrainerNames_others = [
  "Brock",
  "Misty",
  "Lt. Surge",
  "Erika",
  "Koga",
  "Sabrina",
  "Blaine",
  "Giovanni",
  "Blue",
  "Prof. Oak",
  "Lance",
  "Agatha",
  "Bruno",
  "Lorelei",
  "Miyamoto",
  "Game Freak",
  "Nintendo",
  "Silph Co.",
  "Mr. Fuji",
  "Santa Claus",
  "Blue",
  "Archie",
  "Maxie",
  "Cyrus",
  "Team Rocket",
  "Mom",
  "Dad"
]

# List of randomly selected Pokemon Nicknames
RandPokeNick = [
  "Poncho",
  "King",
  "Batar",
  "Pneuma",
  "goo",
  "Shakira",
  "BATMAN",
  "Armstrong",
  "Guten Tag =)",
  "Saturn",
  "BUTTER47",
  "Lakota",
  "Lepizig",
  "Mombacho",
  "Slam",
  "Frogman",
  "Easter",
  "Atari",
  "Regis",
  "Cleopatra",
  "Robin",
  "pthread_cond_init",
  "Pharaoh",
  "Moskva",
  "Skywalker",
  "Minivan",
  "Nevada",
  "CAPTAIN",
  "Buzz",
  "Bolzano",
  "Jabroni",
  "InfiniteFusion.cpp",
  "Paco",
  "Killah",
  "Skyrim",
  "Zeffy",
  "Hydra",
  "Ultimo!",
  "Sohcahtoa",
  "The Beast",
  "Ragnarok",
  "Supernova",
  "Tolkien",
  "♩ DE R△//en♩ ",
  "Martina",
  "Minessota",
  "Sir",
  "crunchy",
  "MACE4",
  "Vouta",
  "Yussef",
  "Dracula",
  "Spikes",
  "Arnold",
  "Grenadine",
  "Piña",
  "rofl",
  "Bulrog",
  "Bubbles",
  "Pompadour",
  "Mew",
  "MEWTHREE",
  "Eclipse",
  "Yoshi",
  "Wonder",
  "Kalashnikov",
  "Spencer",
  "Jingle",
  "Jungle",
  "Asgore",
  "0",
  "Mischief",
  "Lambo",
  "Elvis",
  "Pretzel",
  "Mec",
  "Boromir",
  "Gandalf",
  "Mickey",
  "Michael Jordan",
  "POSIX",
  "pokemon.exe",
  "Frodo",
  "One",
  "Dude",
  "Sandstorm",
  "The Destroyer",
  "Pokenator",
  "Big guy",
  "Mallow",
  "MALLOW",
  "Aladdin",
  "Sluggy",
  "Freaky",
  "fuxj",
  "ur mum",
  "TwerkWobufet",
  "John Wick",
  "Angel",
  "baddybad",
  "Mr. Bean",
  "Lover",
  "HALLOWS",
  "Trucker",
  "idk",
  "Bababa",
  "Absinthe",
  "Fatality",
  "hereyouare",
  "Egg",
  "Mademoiselle",
  "Jolly",
  "Jet",
  "Gourmet",
  "Nocturne",
  "Bo",
  "Foxy",
  "Lady",
  "Deadpool",
  "Mean Joe",
  "Lise",
  "no name",
  "Shards",
  "Mrs. Johnson",
  "Mister",
  "Female",
  "Grand",
  "Polyp",
  "Sao Paulo",
  "Inspector",
  "Vinny",
  "Knight",
  "SpdefSpdAtk",
  "Soul",
  "Saul",
  "Heho",
  "Bluebeard",
  "Whirlio",
  "Managua",
  "Soprano",
  "Doomsday",
  "Mechano",
  "Roboto",
  "Stealy",
  "London",
  "Paris",
  "Barcelona",
  "Tokyo",
  "New York",
  "Wondertrade",
  "wt_poke_01",
  "Moscow",
  "cool",
  "cool guy",
  "AAAAAAAAAA",
  "♂♂♂♂♂♂♂♂♂",
  "♀♀♀♀♀♀♀♀♀",
  "♀",
  "♂",
  "Charlie",
  "SKA",
  "Fatal",
  "P.I.M.P.",
  "Manson",
  "Kilburn",
  "thank you",
  "Lamar",
  "CJ",
  "sup",
  "LOL",
  "^-^",
  "fart69",
  "420",
  "this game sucks",
  "this game is shit",
  "i like this",
  "Bazooka",
  "Scorpio",
  "______",
  "x",
  "Rob",
  "Charlie",
  "Zack",
  "Garou",
  "Artyom",
  "Bert",
  "Passe-partout",
  "Ali",
  "Marty",
  "xxx",
  "Zappa",
  "Carmen",
  "Brad",
  "Ferrari",
  "Floyd",
  "Morrisson",
  "Ti-criss",
  "#pokemon",
  "Rocky",
  "Sony",
  "Microsoft",
  "Combo",
  "poulet",
  "Jesus",
  "Cyrano",
  "Cthulhu",
  "Couillard",
  "Zoombini",
  "Allah",
  "clipou",
  "Muhammad",
  "Gino",
  "password",
  "password123",
  "covid",
  "covfefe",
  "admin",
  "God",
  "spaghetti-o",
  "prawn",
  "1; DROP TABLE pokemon;--",
  "Serberus",
  "Aurora",
  "lmao",
  "Rob Ford",
  "Mew",
  "Arceus",
  "SwaggDab",
  "KOFFING",
  "Rayquaza",
  "ur welcome",
  "Cartman",
  "Switch",
  "Zelda",
  "Link",
  "Mario",
  "Luigi",
  "Waluigi",
  "Kirby",
  "Samus",
  "Donkey Kong",
  "Donkey",
  "Sparky",
  "Bob",
  "Spartacus",
  "Shrek",
  "Martin",
  "Toto",
  "Bobo",
  "Klown",
  "papi",
  "Gaston",
  "farts",
  "$$$",
  "Diego",
  "Samba",
  "Bossa Nova",
  "Reggae",
  "Spock",
  "Jazz",
  "generatedName_1",
  "generatedName_2",
  "generatedName_3",
  "Caesar",
  "Celebi",
  "pikachu",
  "Rorschach",
  "Rock n' Roll",
  "AAAAAAAAAAAA",
  "Gringo",
  "Ringo",
  "Bigmac",
  "Nintendo",
  "Ferocious",
  "xxx",
  ":)",
  "♫ ♫ ♫",
  "Schrroms",
  "GOD",
  "Samantha",
  "Gaga",
  "Audrey",
  "birb",
  "Donut",
  "Jell-o",
  "Tropicana",
  "Sleepy",
  "Kirill",
  "Carbon",
  "thank you!!",
  "hello",
  "Carl",
  "Meow",
  "Marcus",
  "Woof",
  "Carlos",
  "hm_slave",
  "Varicelle",
  "Google",
  "Twitter",
  "Facebook",
  "Mia",
  "Lame-o",
  "Snoop",
  "Mephesto",
  "salut toi",
  "Eric",
  "Kyle",
  "Kenny",
  "Stan",
  "Kevin",
  "Jim",
  "spooky boi",
  "Pam",
  "Stevie",
  "Bravo",
  "Johnny Bravo",
  "Dolores",
  "Junior",
  "Spinacio",
  "Doc",
  "Mailloux",
  "Marley",
  "Leibniz",
  "Jasmine",
  "Wack",
  "Fizzy",
  "Foo",
  "Metrognome",
  "R2D2",
  "my pokéman",
  "POKEMAN1",
  "POKEMAN2",
  "POKEMAN4",
  "Gnome",
  "Warbles",
  "Primavera",
  "Gigi",
  "Scuba",
  "Gulpino",
  "Anthem",
  "Cinderella",
  "Schnapps",
  "Toughman",
  "HASBRO",
  "Primavera",
  "Tapu",
  "Lolu",
  "PKP",
  "Lord",
  "Gollum",
  "Vipa",
  "Ringo",
  "Django",
  "Moses",
  "Porkus",
  "Mallow",
  "Leaf",
  "Red",
  "Wormus",
  "Java",
  "Zag",
  "Zef",
  "Dorothy",
  "pink floyd",
  "Misty",
  "Ash",
  "Satoshi",
  "Sniper",
  "Suzy",
  "Lucy",
  "Molly",
  "Leela",
  "Pauvcon",
  "Fatso",
  "Coolio",
  "Sonata",
  "Romeo",
  "Juliet",
  "Mojito",
  "5BAGGIGUANE",
  "Slug",
  "Love",
  "Bella",
  "Bourbon",
  "The Menace",
  "Shihuang",
  "Kim",
  "Solfege",
  "Kunidé",
  "Kate",
  "Dave",
  "t bo",
  "what",
  "Zebra",
  "Captain",
  "Venimo",
  "Markazus",
  "Otello",
  "The one and only",
  "Ricky",
  "Scree",
  "Creepium",
  "Newton",
  "Blaster",
  "Requiem",
  "Shelley",
  "Steve Winwood",
  "uranium",
  "Princess",
  "Zuzu",
  "Brainiac",
  "P1",
  "P2",
  "Morpheus",
  "Brexit",
  "Boromir",
  "Rick",
  "Morty",
  "Scheiße",
  "Santa",
  "Crumbs",
  "Neo",
  "Michael",
  "Jackson",
  "Adamas",
  "Tina",
  "Scrabble",
  "Tiamath",
  "Raggedy",
  "Rickety",
  "Cricket",
  "Wario",
  "Rex",
  "Fido",
  "Castor",
  "Pollux",
  "Rambo",
  "Skeletor",
  "Speedo",
  "Robocop",
  "Dredd",
  "Nicolas Cage",
  "jean michel",
  "Sammy",
  "Jones",
  "cheers!",
  "Frootloops",
  "T",
  "The Batman",
  "Twerk",
  "Dubstep",
  "Flynn",
  "Bender",
  "uwotm8",
  "KFC",
  "Legolas",
  "Ronald",
  "Jareth",
  "Macarena",
  "Dreamer",
  "Beetlejuice",
  "fann",
  "Gizmo",
  "Cannonball",
  "Copyright",
  "John McClane",
  "Mint",
  "Colonel",
  "Ed",
  "jay jay",
  "Ramen",
  "Rascal",
  "Enigma",
  "",
  "77",
  "420",
  "strong guy",
  "Skyzo",
  "Cozy",
  "Nica",
  "Sticky",
  "Angela",
  "Zala",
  "Cornflake",
  "Spyro",
  "Manhattan",
  "Devon",
  "Passion",
  "Silph",
  "Yan",
  "Double",
  "Doc",
  "Rayman",
  "Taco",
  "Toro",
  "Pokémon Infinite Fusion",
  "uwotm8",
  "ROCKY",
  "Giga",
  "Santana",
  "McCola",
  "Lexy",
  "Kenya",
  "Bean",
  "GameBoy",
  "PlayStation",
  "GameCube",
  "Petit mec",
  "X-Box",
  "AAAAAAAA",
  "cyka",
  "Jetpack",
  "Yankee",
  "Batman",
  "Garfield",
  "Schokolade",
  "Vile",
  "Penny",
  "Lionel",
  "Malicious",
  "Supernova",
  "Agumon",
  "mick jagger",
  "Greymon",
  "Rockstar",
  "Shin",
  "Egg",
  "Emily",
  "garcia",
  "Goku",
  "Vegeta",
  "Nacho",
  "Chachi",
  "Weasley",
  "salut",
  "DEMON",
  "Ponytails",
  "monesti",
  "ticon",
  "macalice",
  "Dixie",
  "Tails",
  "Banzai",
  "Sonic",
  "Mario",
  "Luigi",
  "lol nice try",
  "Anakin",
  "Snape",
  "Conky",
  "fait chier",
  "lamus",
  "Sonic",
  "Harry",
  "Potter",
  "Rumba",
  "pikapika",
  "Never Gonna Give You Up",
  "Peppy",
  "Link",
  "Uber",
  "Lollipop",
  "CURSED",
  "Solid",
  "Rock",
  "Metroid",
  "Obelix",
  "Asterix",
  "Monsta!",
  "virus.exe",
  "Limewire",
  "nothing",
  "rick and morty",
  "a Pokémon",
  "Lilly",
  "Safari",
  "Dreams",
  "Todd",
  "Dino",
  "Jaws",
  "Flatman",
  "Sylvain",
  "Light",
  "Peter",
  "Angel",
  "Corona",
  "Cinnamon",
  "TBK",
  "Tabarnak",
  "Joker",
  "O'Neil",
  "Stu",
  "||||",
  "Nightmare",
  "1",
  "Maniac",
  "Bee Gee",
  "Volleyball",
  "BaBa",
  "Nemo",
  "25",
  "Puppy",
  "Puffy",
  "Fi",
  "FASHION",
  "Chuckles",
  "Bacon",
  "Nightman",
  "Dayman",
  "Jojo",
  "Moon",
  "Unity",
  "Zappa",
  "McNeil",
  "Bowie",
  "Hendrix",
  "Bunny",
  "Jina",
  "Gipsy",
  "$$$",
  "Scooby",
  "Marcarcand",
  "Artist",
  "Galleon",
  "Hilary Clinton",
  "Metroid",
  "Ali",
  "Snoopy",
  "Mimi",
  "Quebec",
  "Zexy",
  "woopsie",
  "wrong pokemon",
  "MISSINGNO",
  "MISSINGNAME",
  "Proton",
  "Numba 1", "Number 2", "Number 3", "Number 4", "Number 5", "Number 6", "Number 7",
  "pokeman",
  "hm_slave",
  "hm_slave01",
  "Gio",
  "Domingo",
  "Domino",
  "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII",
  "Chad",
  "try again",
  "Ridley",
  "Ursaring",
  "Charlie",
  "Justin Trudeau",
  "273-8255",
  "Gino",
  "Woody",
  "Buzz",
  "Zerg",
  "Macho",
  "Paddle",
  "Tennis",
  "Chidi",
  "OFCOURS-_-",
  "Baseball",
  "2738255",
  "call me",
  "Lanky",
  "DK",
  "Tiny",
  "Splashy",
  "Tomato",
  "<3",
  "Z",
  "Zorro",
  "Zoe",
  "Frank",
  "Jeff",
  "Redneck",
  "good IVs",
  "Rooster",
  "Peyton",
  "Nutella",
  "Bell",
  "Soup",
  "Yoda",
  "Corsola",
  "Glass",
  "Rocket",
  "Vodka",
  "I <3 U",
  "Ninja",
  "Papa",
  "Mama",
  "Fortnite",
  "Eleanor",
  "Pepito",
  "Dolphin",
  "Lucky",
  "Amour",
  "Nova",
  "my name",
  "AAAAAH!!!",
  "N64",
  "Turnips",
  "Hermione",
  "Narnia",
  "Obama",
  "Freebie",
  "un joli pokémon",
  "Unit-3",
  "Happy",
  "Terror",
  "Kanto", "Johto", "Hoenn", "Sinnoh", "Unova", "Kalos", "Alola",
  "Jar Jar",
  "Garcia",
  "Reaper",
  "193119",
  "pokemon.png",
  "Muscles",
  "Buddy",
  "asl",
  "test",
  "Simba",
  "Blacky",
  "Mufasa",
  "caca",
  "Neptune",
  "MASTER",
  "Yoga",
  "McDo",
  "yourself",
  "something",
  "something better",
  "this", "that",
  "it",
  "愛",
  "Franz",
  "Muffinman",
  "huh?",
  "Rachid",
  "Naruto",
  "bling bling",
  "gimme $$$",
  "Zombie",
  "Woofster",
  "Turing",
  "d00d",
  "Billy",
  "qt",
  "Digimon",
  "Elsa",
  "Candy",
  "Mini",
  "Squash",
  "Queen",
  "King",
  "Prince",
  "Princess",
  "Emperor",
  "Mimosa",
  "Heisenberg",
  "Java",
  "Copernicus",
  "Lloyd",
  "BOOM",
  "Cloud",
  "Jeremy",
  "Madrid",
  "Garfield",
  "Gin",
  "Luke",
  "gracias",
  "Lucky",
  "Pinnocchio",
  "Kappa",
  "Budweiser",
  "Ruby",
  "Boogieman",
  "Disco",
  "sweatie",
  "ACDC",
  "coco",
  "NullPointerException",
  "Myriam",
  "pink",
  "Gump",
  "shazam",
  "Stefano",
  "Moby",
  "Sashimi",
  "Vito",
  "Chippy",
  "Boogie",
  "Funky",
  "Groot",
  "Chewbacca",
  "Schrroms",
  "Boris",
  "maymay"
]

def pbWonderTrade(lvl, except = [], except2 = [], premiumWonderTrade = true)
  # for i in 0...except.length # Gets ID of pokemon in exception array
  #   except[i]=getID(PBSpecies,except[i]) if !except[i].is_a?(Integer)
  # end
  # for i in 0...except2.length # Gets ID of pokemon in exception array
  #   except2[i]=getID(PBSpecies,except2[i]) if !except2[i].is_a?(Integer)
  # end
  # ignoreExcept = rand(100) == 0 #tiny chance to include legendaries
  #
  # except+=[]
  rare = premiumWonderTrade
  chosen = pbChoosePokemon(1, 2, # Choose eligable pokemon
                           proc {
                             |poke| !poke.egg? && !(poke.isShadow?) && # No Eggs, No Shadow Pokemon
                               (poke.level >= lvl) && !(except.include?(poke.species)) # None under "lvl", no exceptions.
                           })
  poke = $Trainer.party[pbGet(1)]
  $PokemonBag.pbStoreItem(poke.item, 1) if poke.item != nil
  myPoke = poke.species
  chosenBST = calcBaseStats(myPoke)
  # The following excecption fields are for hardcoding the blacklisted pokemon
  # without adding them in the events.
  #except+=[]
  except2 += [:ARCEUS, :MEW, :CELEBI, :LUGIA, :HOOH, :MEWTWO]
  if pbGet(1) >= 0
    species = 0
    luck = rand(5) + 1
    rarecap = (rand(155 + poke.level) / (1 + rand(5))) / luck
    bonus = 0
    while (species == 0) # Loop Start
      bonus += 5 #+ de chance de pogner un bon poke a chaque loop (permet d'eviter infinite loop)

      species = rand(PBSpecies.maxValue) + 1
      bst = calcBaseStats(species)
      # Redo the loop if pokemon is too evolved for its level
      #species=0 if lvl < pbGetMinimumLevel(species)# && pbGetPreviousForm(species) != species # && pbGetPreviousForm(species)!=species
      # Redo the loop if the species is an exception.
      species = 0 if checkifBlacklisted(species, except2) && !ignoreExcept #except2.include?(species)
      #Redo loop if above BST
      bstLimit = chosenBST + bonus# + $game_variables[120]
      if !premiumWonderTrade
        bstLimit-=50
      end
      species = 0 if bst > bstLimit
      if species > 0 && premiumWonderTrade
        species = 0 if !customSpriteExists(species)
      end
      if species > 0
        skipLegendaryCheck = premiumWonderTrade && rand(100) < luck
        species = 0 if pokemonIsPartLegendary(species) && !$game_switches[BEAT_THE_LEAGUE] && !skipLegendaryCheck
      end
      #Redo loop if below BST - 200
      species = 0 if bst < (chosenBST - 200)

      # raise _INTL("{1}'s bst ist {2}, new ist {3}",myPoke,chosenBST,bst)

      # species=0 if (except.include?(species) && except2.include?(species))
      # use this above line instead if you wish to neither receive pokemon that YOU
      # cannot trade.
      if rare == true #turn on rareness
        if species > 0
          rareness = GameData::Species.get(species).catch_rate
          species = 0 if rarecap >= rareness
        end
      end
    end
    randTrainerNames = RandTrainerNames_male + RandTrainerNames_female + RandTrainerNames_others
    tname = randTrainerNames[rand(randTrainerNames.size)] # Randomizes Trainer Names
    pname = RandPokeNick[rand(RandPokeNick.size)] # Randomizes Pokemon Nicknames

    #num of Wondertrade - 1
    if premiumWonderTrade
      $game_variables[PREMIUM_WONDERTRADE_LEFT] -= 1
    else
      $game_variables[STANDARD_WONDERTRADE_LEFT] -= 1
    end

    newpoke = pbStartTrade(pbGet(1), species, pname, tname, 0, true) # Starts the trade
    #lower level by 1 to prevent abuse
    if poke.level > 25
      newpoke.level = poke.level - 1
    end
  else
    return -1
  end
end

def pbGRS(minBST, chosenBST, luck, rare, except2)
  #pbGenerateRandomSpecies (le nom doit etre short pour etre callé dans events)
  # The following excecption fields are for hardcoding the blacklisted pokemon
  # without adding them in the events.
  #except+=[]
  except2 += []
  species = 0
  #luck = rand(5)+1
  rarecap = (rand(rare) / (1 + rand(5))) / luck
  bonus = 0
  while (species == 0) # Loop Start
    bonus += 5 #+ de chance de pogner un bon poke a chaque loop (permet d'eviter infinite loop)

    species = rand(PBSpecies.maxValue) + 1
    bst = calcBaseStats(species)
    # Redo the loop if pokemon is too evolved for its level
    #species=0 if lvl < pbGetMinimumLevel(species)# && pbGetPreviousForm(species) != species # && pbGetPreviousForm(species)!=species
    # Redo the loop if the species is an exception.
    species = 0 if checkifBlacklisted(species, except2) #except2.include?(species)
    #Redo loop if above BST
    species = 0 if bst > chosenBST + $game_variables[120] + bonus

    #Redo loop if below BST - 200
    species = 0 if bst < (chosenBST - 200)

    # raise _INTL("{1}'s bst ist {2}, new ist {3}",myPoke,chosenBST,bst)

    # species=0 if (except.include?(species) && except2.include?(species))
    # use this above line instead if you wish to neither receive pokemon that YOU
    # cannot trade.
    if rare == true #turn on rareness
      rareness = GameData::Species.get(species).catch_rate
      species = 0 if rarecap >= rareness
    end
  end
  return species
end

def calcBaseStats(species)
  stats = GameData::Species.get(species).base_stats
  sum = 0
  sum += stats[:HP]
  sum += stats[:ATTACK]
  sum += stats[:DEFENSE]
  sum += stats[:SPECIAL_ATTACK]
  sum += stats[:SPECIAL_DEFENSE]
  sum += stats[:SPEED]
  return sum
  #
  # basestatsum = $pkmn_dex[species][5][0] # HP
  # basestatsum +=$pkmn_dex[species][5][1] # Attack
  # basestatsum +=$pkmn_dex[species][5][2] # Defense
  # basestatsum +=$pkmn_dex[species][5][3] # Speed
  # basestatsum +=$pkmn_dex[species][5][4] # Special Attack
  # basestatsum +=$pkmn_dex[species][5][5]  # Special Defense
  # return basestatsum
end

def checkifBlacklisted(species, blacklist)
  return true if blacklist.include?(getBasePokemonID(species, true))
  return true if blacklist.include?(getBasePokemonID(species, false))
  return false
end