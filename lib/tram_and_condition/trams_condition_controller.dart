import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {
  var isAccepted = false.obs;

  /// Holds the T&C text in different languages
  RxMap<String, List<Map<String, String>>> termsTexts = <String, List<Map<String, String>>>{}.obs;

  /// Holds the introductory text in different languages
  RxMap<String, String> introTexts = <String, String>{}.obs;

  /// Holds the app bar title in different languages
  RxMap<String, String> appBarTitles = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize app bar titles for each language
    appBarTitles.value = {
      'English': 'Terms & Conditions',
      'Español': 'Términos y Condiciones',
      'Italiano': 'Termini e Condizioni',
      'Português': 'Termos e Condições',
      'Polski': 'Regulamin',
      'Français': 'Termes et Conditions',
      'Türkçe': 'Şartlar ve Koşullar',
    };

    // Initialize intro texts for each language
    introTexts.value = {
      'English': 'Please read these Terms and Conditions carefully before using our mobile application. By accessing or using our app, you agree to be bound by these terms.',
      'Español': 'Por favor, lea estos Términos y Condiciones cuidadosamente antes de usar nuestra aplicación móvil. Al acceder o usar nuestra aplicación, usted acepta estar sujeto a estos términos.',
      'Italiano': 'Si prega di leggere attentamente questi Termini e Condizioni prima di utilizzare la nostra applicazione mobile. Accedendo o utilizzando la nostra app, accetti di essere vincolato da questi termini.',
      'Português': 'Por favor, leia estes Termos e Condições atentamente antes de usar nosso aplicativo móvil. Ao acessar ou usar nosso aplicativo, você concorda em ficar vinculado a esses termos.',
      'Polski': 'Przed użyciem naszej aplikacji mobilnej prosimy o uważne zapoznanie się z niniejszym Regulaminem. Korzystając z naszej aplikacji, zgadzasz się być związany tymi warunkami.',
      'Français': 'Veuillez lire attentivement ces Termes et Conditions avant d\'utiliser notre application mobile. En accédant ou en utilisant notre application, vous acceptez d\'être lié par ces conditions.',
      'Türkçe': 'Mobil uygulamamızı kullanmadan önce lütfen bu Şartlar ve Koşulları dikkatlice okuyun. Uygulamamıza erişerek veya kullanarak, bu şartlarla bağlı olmayı kabul etmiş olursunuz.',
    };

    // Initialize T&C for each language
    termsTexts.value = {
      'English': [
        {'heading': '1. Acceptance of Terms', 'body': 'By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement. This includes all policies and guidelines incorporated by reference in these Terms.'},
        {'heading': '2. User Accounts', 'body': 'When you create an account with us, you must provide accurate, complete, and current information. You are responsible for safeguarding the password and for all activities that occur under your account. We reserve the right to suspend or terminate accounts that violate our terms.'},
        {'heading': '3. Privacy Policy', 'body': 'Your use of our application is also governed by our Privacy Policy. Please review our Privacy Policy, which also governs the application and informs users of our data collection practices. We are committed to protecting your personal information.'},
        {'heading': '4. User Content', 'body': 'Our application allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material. You retain ownership of any intellectual property rights that you hold in that content, but grant us a license to use it for service operation.'},
        {'heading': '5. Prohibited Activities', 'body': 'You agree not to engage in any of the following prohibited activities: violating laws, infringing intellectual property, distributing malware, spamming, or interfering with the service. We may investigate violations and cooperate with authorities.'},
      ],

      'Español': [
        {'heading': '1. Aceptación de Términos', 'body': 'Al acceder y utilizar esta aplicación, usted acepta y se compromete a cumplir con los términos y disposiciones de este acuerdo. Esto incluye todas las políticas y directrices incorporadas por referencia en estos Términos.'},
        {'heading': '2. Cuentas de Usuario', 'body': 'Cuando crea una cuenta con nosotros, debe proporcionar información precisa, completa y actual. Usted es responsable de proteger la contraseña y de todas las actividades que ocurran bajo su cuenta. Nos reservamos el derecho de suspender o terminar cuentas que violen nuestros términos.'},
        {'heading': '3. Política de Privacidad', 'body': 'Su uso de nuestra aplicación también se rige por nuestra Política de Privacidad. Por favor revise nuestra Política de Privacidad, que también gobierna la aplicación e informa a los usuarios sobre nuestras prácticas de recopilación de datos. Estamos comprometidos a proteger su información personal.'},
        {'heading': '4. Contenido del Usuario', 'body': 'Nuestra aplicación le permite publicar, enlazar, almacenar, compartir y poner a disposición cierta información, texto, gráficos, videos u otro material. Usted mantiene la propiedad de cualquier derecho de propiedad intelectual que posea sobre ese contenido, pero nos otorga una licencia para usarlo para la operación del servicio.'},
        {'heading': '5. Actividades Prohibidas', 'body': 'Usted acepta no participar en ninguna de las siguientes actividades prohibidas: violar leyes, infringir la propiedad intelectual, distribuir malware, enviar spam o interferir con el servicio. Podemos investigar violaciones y cooperar con las autoridades.'},
      ],

      'Italiano': [
        {'heading': '1. Accettazione dei Termini', 'body': 'Accedendo e utilizzando questa applicazione, accetti di essere vincolato dai termini e dalle condizioni di questo accordo. Ciò include tutte le politiche e le linee guida incorporate per riferimento in questi Termini.'},
        {'heading': '2. Account Utente', 'body': 'Quando crei un account con noi, devi fornire informazioni accurate, complete e aggiornate. Sei responsabile della protezione della password e di tutte le attività che avvengono sotto il tuo account. Ci riserviamo il diritto di sospendere o terminare account che violano i nostri termini.'},
        {'heading': '3. Politica sulla Privacy', 'body': 'L\'uso della nostra applicazione è anche disciplinato dalla nostra Politica sulla Privacy. Si prega di consultare la nostra Politica sulla Privacy, che regola anche l\'applicazione e informa gli utenti sulle nostre pratiche di raccolta dati. Ci impegniamo a proteggere le tue informazioni personali.'},
        {'heading': '4. Contenuto Utente', 'body': 'La nostra applicazione ti consente di pubblicare, collegare, memorizzare, condividere e rendere disponibili determinate informazioni, testi, grafica, video o altro materiale. Mantieni la proprietà di eventuali diritti di proprietà intellettuale che possiedi su quel contenuto, ma ci concedi una licenza per usarlo per il funzionamento del servizio.'},
        {'heading': '5. Attività Proibite', 'body': 'Accetti di non impegnarti in nessuna delle seguenti attività proibite: violazione delle leggi, violazione della proprietà intellettuale, distribuzione di malware, spam ou interferenza con il servizio. Possiamo indagare sulle violazioni e collaborare con le autorità.'},
      ],

      'Português': [
        {'heading': '1. Aceitação dos Termos', 'body': 'Ao acessar e usar este aplicativo, você aceita e concorda em estar vinculado aos termos e disposições deste acordo. Isso inclui todas as políticas e diretrizes incorporadas por referência nestes Termos.'},
        {'heading': '2. Contas de Usuário', 'body': 'Ao criar uma conta conosco, você deve fornecer informações precisas, completas e atualizadas. Você é responsável por proteger a senha e por todas as atividades que ocorrem em sua conta. Reservamo-nos o direito de suspender ou encerrar contas que violem nossos termos.'},
        {'heading': '3. Política de Privacidade', 'body': 'O uso do nosso aplicativo também é regido pela nossa Política de Privacidade. Por favor, revise nossa Política de Privacidade, que também governa o aplicativo e informa os usuários sobre nossas práticas de coleta de dados. Estamos comprometidos em proteger suas informações pessoais.'},
        {'heading': '4. Conteúdo do Usuário', 'body': 'Nosso aplicativo permite que você publique, vincule, armazene, compartilhe e disponibilize determinadas informações, textos, gráficos, vídeos ou outro material. Você mantém a propriedade de quaisquer direitos de propriedade intelectual que detenha sobre esse conteúdo, mas nos concede uma licença para usá-lo para a operação del serviço.'},
        {'heading': '5. Atividades Proibidas', 'body': 'Você concorda em não se envolver em nenhuma das seguintes atividades proibidas: violar leis, infringir propriedade intelectual, distribuir malware, enviar spam ou interferir com o serviço. Podemos investigar violações e cooperar com as autoridades.'},
      ],

      'Polski': [
        {'heading': '1. Akceptacja Warunków', 'body': 'Korzystając z tej aplikacji, akceptujesz i zgadzasz się przestrzegać warunków i postanowień tej umowy. Obejmuje to wszystkie polityki i wytyczne włączone przez odniesienie w tych Warunkach.'},
        {'heading': '2. Konta Użytkowników', 'body': 'Tworząc konto u nas, musisz podać dokładne, kompletne i aktualne informacje. Jesteś odpowiedzialny za zabezpieczenie hasła i wszystkie działania związane z Twoim kontem. Zastrzegamy sobie prawo do zawieszenia lub zakończenia kont naruszających nasze warunki.'},
        {'heading': '3. Polityka Prywatności', 'body': 'Korzystanie z naszej aplikacji jest również regulowane przez naszą Politykę Prywatności. Prosimy o zapoznanie się z naszą Polityką Prywatności, która reguluje aplikację e informuje użytkowników o naszych praktykach zbierania danych. Dbamy o ochronę Twoich danych osobowych.'},
        {'heading': '4. Treści Użytkownika', 'body': 'Nasza aplikacja umożliwia publikowanie, linkowanie, przechowywanie, udostępnianie i udostępnianie określonych informacji, tekstów, grafik, filmów lub innych materiałów. Zachowujesz prawa własności intelektualnej do treści, ale udzielasz nam licencji na korzystanie z nich w celu działania usługi.'},
        {'heading': '5. Zabronione Działania', 'body': 'Zgadzasz się nie uczestniczyć w żadnych z następujących zabronionych działań: naruszanie prawa, naruszanie własności intelektualnej, dystrybucja złośliwego oprogramowania, spamowanie lub ingerencja w usługę. Możemy badać naruszenia i współpracować z władzami.'},
      ],

      'Français': [
        {'heading': '1. Acceptation des Termes', 'body': 'En accédant et en utilisant cette application, vous acceptez d\'être lié par les termes et dispositions de cet accord. Cela inclut toutes les politiques et directives incorporées par référence dans ces Termes.'},
        {'heading': '2. Comptes Utilisateurs', 'body': 'Lorsque vous créez un compte chez nous, vous devez fournir des informations exactes, complètes et à jour. Vous êtes responsable de la protection du mot de passe et de toutes les activités se produisant sous votre compte. Nous nous réservons le droit de suspendre ou de résilier les comptes qui enfreignent nos conditions.'},
        {'heading': '3. Politique de Confidentialité', 'body': 'Votre utilisation de notre application est également régie par notre Politique de Confidentialité. Veuillez consulter notre Politique de Confidentialité, qui régit également l\'application et informe les utilisateurs de nos pratiques de collecte de données. Nous nous engageons à protéger vos informations personnelles.'},
        {'heading': '4. Contenu Utilisateur', 'body': 'Notre application vous permet de publier, lier, stocker, partager et rendre disponible certaines informations, textes, graphiques, vidéos ou autres contenus. Vous conservez la propriété de tout droit de propriété intellectuelle que vous détenez sur ce contenu, mais vous nous accordez une licence pour l\'utiliser pour l\'exploitation du service.'},
        {'heading': '5. Activités Interdites', 'body': 'Vous acceptez de ne pas participer à l\'une des activités interdites suivantes : violation des lois, atteinte à la propriété intellectuelle, distribution de logiciels malveillants, spam ou interférence avec le service. Nous pouvons enquêter sur les violations et coopérer avec les autorités.'},
      ],

      'Türkçe': [
        {'heading': '1. Şartların Kabulü', 'body': 'Bu uygulamaya erişerek ve kullanarak, bu anlaşmanın şartlarına ve hükümlerine bağlı kalmayı kabul etmiş olursunuz. Bu, bu Şartlara atıfta bulunularak dahil edilen tüm politikaları ve yönergeleri içerir.'},
        {'heading': '2. Kullanıcı Hesapları', 'body': 'Bizimle bir hesap oluşturduğunuzda, doğru, eksiksiz ve güncel bilgiler sağlamalısınız. Parolayı korumaktan ve hesabınız altında gerçekleşen tüm aktivitelerden siz sorumlusunuz. Şartlarımızı ihlal eden hesapları askıya alma veya sonlandırma hakkımız saklıdır.'},
        {'heading': '3. Gizlilik Politikası', 'body': 'Uygulamamızı kullanmanız aynı zamanda Gizlilik Politikamız tarafından da yönetilmektedir. Lütfen uygulamayı ve veri toplama uygulamalarımızı kullanıcıya bildiren Gizlilik Politikamızı inceleyin. Kişisel bilgilerinizi korumaya kararlıyız.'},
        {'heading': '4. Kullanıcı İçeriği', 'body': 'Uygulamamız belirli bilgileri, metinleri, grafikleri, videoları veya diğer materyalleri paylaşmanıza, depolamanıza ve kullanılabilir hale getirmenize olanak tanır. Bu içerikte sahip olduğunuz herhangi bir fikri mülkiyet hakkının sahibi olmaya devam edersiniz, ancak hizmetin işletilmesi için bize kullanım lisansı verirsiniz.'},
        {'heading': '5. Yasaklı Faaliyetler', 'body': 'Aşağıdaki yasaklı faaliyetlerden herhangi birine katılmamayı kabul edersiniz: yasaları ihlal etmek, fikri mülkiyeti ihlal etmek, kötü amaçlı yazılım dağıtmak, spam yapmak veya hizmete müdahale etmek. İhlalleri araştırabilir ve yetkililerle işbirliği yapabiliriz.'},
      ],
    };
  }

  /// Toggle acceptance checkbox
  void toggleAcceptance(bool? value) {
    if (value != null) {
      isAccepted.value = value;
    }
  }
}