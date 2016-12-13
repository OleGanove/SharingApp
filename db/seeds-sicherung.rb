# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Fpost.destroy_all

Fpost.create!([{
  description:  "Hartnäckig hält sich die E-Mail als nahezu universeller digitaler Kommunikationskanal. Für das Marketing macht die E-Mail vor allem die sehr gute Messbarkeit attraktiv. Doch viele Unternehmen nutzen diese Gelegenheit überhaupt nicht.",
  link: "http://www.werbewoche.ch/marketing/2016-11-29/die-erfolgsfaktoren-im-e-mail-marketing", 
  pinned: false,
  time_ago: 77,
  picture: "ava1.jpg",
  first_name: "Robert",
  last_name: "Pfaff"
  },
  {
  description:  "In der Deutschen Nationalbibliothek gilt ab sofort «digital first». Liegt ein Buch digital vor, erhalten Leser dies zur Nutzung und nicht die gedruckte Version.",
  link: "http://www.faz.net/aktuell/feuilleton/buecher/themen/neue-leseregeln-fuer-die-deutsche-nationalbibliothek-14538350.html",
  pinned: true,
  time_ago: 153,
  picture: "ava2.jpg",
  first_name: "Andreas",
  last_name: "Kohl"
  },
  {
  description:  "Aus dem Silicon Valley in Kalifornien kommen vor allem technologische Innovationen. Doch eine neue Idee fokussiert sich auf ein anderes Thema: die Kindererziehung.",
  link: "http://www.nzz.ch/nzzas/nzz-am-sonntag/spieltheorie-das-hast-du-gut-gemacht-ld.130871",
  pinned: true,
  time_ago: 173,
  picture: "ava3.jpg",
  first_name: "Diana",
  last_name: "Hartmann"
  },
  {
  description:  "Ein Autor des progressiven Magazins Vice hat sich für ein eintägiges Praktikum bei der Pressestelle der Berliner AfD beworben - und wurde zu seiner eigenen Überraschung genommen.",
  link: "http://www.vice.com/de/read/ich-war-praktikant-bei-der-berliner-afd",
  pinned: true,
  time_ago: 204,
  picture: "ava4.jpg",
  first_name: "Kristian",
  last_name: "Werfel"
  },
  {
  description:  "Interessante Studienergebnisse: 53 Prozent der Journalisten in Deutschland sind der Ansicht, dass sich ihre Rolle durch soziale Medien grundlegend verändert hat. 42 Prozent könnten ohne Social Media nicht arbeiten.",
  link: "http://bernetblog.ch/2016/11/21/ssocial-journalism-studie-deutschland-wie-soziale-medien-die-rolle-des-journalisten-veraendern/",
  pinned: true,
  time_ago: 210,
  picture: "ava5.jpg",
  first_name: "Jennifer",
  last_name: "Eichel"
  },
  {
  description:  "Shannen Doherty, vielen bekannt als Brenda aus der 90er Kult-Serie Beverly Hills 90210, erhielt im Jahr 2015 eine Krebs-Diagnose. Doch trotz anstrengender Behandlung steht sie weiterhin vor der Kamera.",
  link: "http://www.gala.de/stars/news/shannen-doherty-der-krebs-haelt-sie-nicht-vom-arbeiten-ab_1568656.html",
  pinned: true,
  time_ago: 226,
  picture: "ava6.jpg",
  first_name: "Matthias",
  last_name: "Schulz"
  },
  {
  description:  "Kein besonders langer oder ausführlich recherchierter Artikel, aber er spricht einen nicht zu vernachlässigenden Punkt an: Wenn es um Toiletten geht, ist der sonst so moderne, zivilisierte Westen eher rückständig.",
  link: "http://www.handelsblatt.com/politik/weltgeschichten/wc-kultur-in-asien-beim-klo-ist-der-westen-ein-entwicklungsland/14856734.html?mwl=ok",
  pinned: true,
  time_ago: 309,
  picture: "ava7.jpg",
  first_name: "Dominik",
  last_name: "Neustadt"
  },
  {
  description:  "Wer im Raum Zürich lebt oder die Schweizer Metropole besucht und sich für Literatur interessiert, für den gibt es jetzt eine mobile App, die einem mit elf Spaziergängen Einblicke in Schauplätze wichtiger Literaturwerke gibt.",
  link: "http://www.nzz.ch/zuerich/zuercher-autoren-mit-einem-fuss-in-der-welt-der-literatur-ld.130157",
  pinned: true,
  time_ago: 330,
  picture: "ava8.jpg",
  first_name: "Mike",
  last_name: "Duerr"
  },
  {
  description:  "Die hier geschilderte Entstehungsgeschichte des Fahrrads klingt skurril, sei aber unter Historikern und Naturwissenschaftlern weitgehend Konsens.",
  link: "http://www.spiegel.de/einestages/200-jahre-fahrrad-karl-drais-und-seine-erfindung-fuer-milliarden-a-1120282.html",
  pinned: true,
  time_ago: 639,
  picture: "ava9.jpg",
  first_name: "Daniela",
  last_name: "Freud"
  },
  {
  description:  "Psychische Beschwerden sind nicht exklusiv Menschen vorbehalten. Auch Tiere können von einem schweren Gemüt betroffen sein. Bei Haustieren beruht dies meist auf Missverständnissen zwischen Tier und Halter.",
  link: "https://kamikatzezwerglis.com/2016/01/16/haustiere-psychische-probleme-sind-bei-jedem-tier-moeglich/",
  pinned: true,
  time_ago: 669,
  picture: "ava10.jpg",
  first_name: "Lisa",
  last_name: "Vogel"
}])


p "Created #{Fpost.count} posts"