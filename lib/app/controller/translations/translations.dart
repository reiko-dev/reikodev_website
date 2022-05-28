import 'package:get/get.dart';

const lifeIsShort = "Life is short, so come say hi";
const letsStarAJourney = "Let's start a journey";
const reikoEmail = "reikodeveloper@gmail.com";
const scrollToDiscover = "scroll to discover";
const top = "TOP";
const copyrightsTxt = "© 2022 Reiko. All rights reserved.";

const projects = "projects";
const more = "more";

const gallery = "gallery";

const codeByReiko = "© Code by Reiko";

const reikoVitorLucas = "Reiko (Vitor Lucas)";
const homeIntro1 = "Hello World! I'm";
const homeIntro2 =
    "an Information Systems Analyst and a Flutter Developer. I enjoy creating new things and experimenting with new technologies";

const home = "home";
const work = "work";
const about = "about";
const contact = "contact";
const mindset = '"I do what is necessary to turn a vision into reality"';

const splashScreenText = "Reiko (Vitor Lucas)";

const getInTouch = "Get in touch";
const aboutText =
    "As a self-taught i have the mindset of: \"I don't know how to do it yet, but i'll figure it out\". That's my superpower.\n\n"
    //P2
    "Whener somebody asks me \"What's your job exactly?\",  the answer is simple: \"I do what is necessary to turn a vision into reality.\" "
    "I search, i ask for help, i teach and learn, growing with every problem i face, this is how i'm built.\n\n"
    //P3
    "Since the first time I got my hands on a personal computer, at the age of 12 (i guess), I understood that the possibilities for creation "
    "are infinite, well the digital world had never been so big as today. Thus, I never concerned myself about the \"how\" of an idea, but "
    "rather with the \"what\" and the \"why.\" If the answer to both questions would satisfy me, I would always find a way to turn a vision "
    "into reality.\n\n"
    //P4
    "Through constant self-education in the software development field, coupled with my business and cultural studies, over the years, I have "
    "trained myself to be versatile and creative as needed.\n\n"
    //P5
    "Every new software development discipline I immerse myself into is a way for me to explore more about the craft, the philosophy, the "
    "immense beauty of a digital solution as a whole.\n\n"
    //P6
    "That is not a job to me. It's a state of mind.";

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          letsStarAJourney: letsStarAJourney,
          lifeIsShort: lifeIsShort,
          reikoEmail: reikoEmail,
          scrollToDiscover: scrollToDiscover,
          copyrightsTxt: copyrightsTxt,
          projects: projects,
          more: more,
          gallery: gallery,
          codeByReiko: codeByReiko,
          reikoVitorLucas: reikoVitorLucas,
          homeIntro1: homeIntro1,
          homeIntro2: homeIntro2,
        },
        'pt_BR': {
          letsStarAJourney: letsStarAJourney,
          lifeIsShort:
              "Está buscando criar impacto online e transformar ele em crescimento? Eu posso te oferecer isso! Mande um e-mail para",
          reikoEmail: reikoEmail,
          scrollToDiscover: "role para descobrir",
          copyrightsTxt: copyrightsTxt,
          projects: "projetos",
          more: "mais",
          gallery: "galeria",
          codeByReiko: codeByReiko,
          reikoVitorLucas: reikoVitorLucas,
          homeIntro1: "Olá mundo! Eu sou",
          homeIntro2:
              "Analista de Sistemas de Informação e Flutter Developer. Eu ani criar coisas novas e experimentar novas tecnologias",
        },
      };
}
