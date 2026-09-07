// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TEMPORIZADOR DE BOXEO';

  @override
  String get phaseWarmup => 'CALENTAMIENTO';

  @override
  String get phaseRound => 'ASALTO';

  @override
  String get phaseRest => 'DESCANSO';

  @override
  String get phaseFinished => 'COMBATE TERMINADO';

  @override
  String get phaseReady => 'LISTO';

  @override
  String roundsAhead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count asaltos',
      one: 'Queda 1 asalto',
    );
    return '$_temp0';
  }

  @override
  String get getReady => 'Prepárate...';

  @override
  String roundProgress(int current, int total) {
    return 'Asalto $current / $total';
  }

  @override
  String completedRounds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count / $count asaltos completados',
      one: '1 / 1 asalto completado',
    );
    return '$_temp0';
  }

  @override
  String get startButton => 'Comenzar';

  @override
  String get startNewFightButton => 'Comenzar nueva pelea';

  @override
  String get pauseButton => 'Pausar';

  @override
  String get resumeButton => 'Reanudar';

  @override
  String get stopButton => 'Detener';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get stopDialogTitle => '¿Detener la pelea?';

  @override
  String get stopDialogBody =>
      'Esto detendrá el temporizador por completo y lo reiniciará desde el principio.';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsProfileSection => 'Perfil';

  @override
  String get settingsSecuritySection => 'Seguridad';

  @override
  String get settingsTimerSection => 'Temporizador';

  @override
  String get settingsAppearanceSection => 'Apariencia';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get modesMenuTitle => 'Modos';

  @override
  String get modesMenuSubtitle => 'Asaltos, tiempos y preajustes';

  @override
  String get themeMenuTitle => 'Tema';

  @override
  String get languageMenuTitle => 'Idioma';

  @override
  String get aboutMenuTitle => 'Acerca de';

  @override
  String get termsMenuTitle => 'Términos y condiciones';

  @override
  String get privacyMenuTitle => 'Política de privacidad';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signInSubtitle =>
      'Inicia sesión para proteger tu configuración o sigue usando el temporizador localmente.';

  @override
  String get continueWithoutAccount => 'Continuar sin cuenta';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get fieldRequired => 'Este campo es obligatorio.';

  @override
  String get unexpectedError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get changeEmail => 'Cambiar correo electrónico';

  @override
  String get newEmail => 'Nuevo correo electrónico';

  @override
  String get invalidEmail => 'Introduce un correo electrónico válido.';

  @override
  String get emailUpdated => 'Se solicitó la actualización del correo.';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get passwordUpdated => 'Contraseña actualizada.';

  @override
  String get saveButton => 'Guardar';

  @override
  String get biometricUnlock => 'Desbloqueo biométrico / Face ID';

  @override
  String get biometricUnlockSubtitle =>
      'Requerir autenticación al volver a la aplicación';

  @override
  String get biometricUnavailable =>
      'La autenticación biométrica no está disponible.';

  @override
  String get biometricEnableReason =>
      'Activar desbloqueo biométrico para Boxing Timer';

  @override
  String get biometricResumeReason => 'Desbloquear Boxing Timer';

  @override
  String get biometricLockTitle => 'Boxing Timer está bloqueado';

  @override
  String get biometricLockBody => 'Autentícate para continuar.';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get chooseThemeTitle => 'Elegir tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get chooseLanguageTitle => 'Elegir idioma';

  @override
  String get languageSystemDefault => 'Predeterminado del sistema';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get modesTitle => 'Modos';

  @override
  String get newModeButton => 'Nuevo modo';

  @override
  String get newModeTitle => 'Nuevo modo';

  @override
  String get editModeTitle => 'Editar modo';

  @override
  String get nameFieldLabel => 'Nombre';

  @override
  String get roundsSectionTitle => 'ASALTOS';

  @override
  String get roundsLabel => 'Asaltos';

  @override
  String get roundDurationSectionTitle => 'DURACIÓN DEL ASALTO';

  @override
  String get restDurationSectionTitle => 'DURACIÓN DEL DESCANSO';

  @override
  String get minutesLabel => 'Minutos';

  @override
  String get secondsLabel => 'Segundos';

  @override
  String get saveModeButton => 'Guardar modo';

  @override
  String get nameRequiredError => 'Ponle un nombre a este modo.';

  @override
  String get roundDurationRequiredError =>
      'La duración del asalto debe ser mayor que 0.';

  @override
  String get duplicateTooltip => 'Duplicar';

  @override
  String get editTooltip => 'Editar';

  @override
  String get deleteTooltip => 'Eliminar';

  @override
  String get deleteModeDialogTitle => '¿Eliminar modo?';

  @override
  String deleteModeDialogBody(String name) {
    return 'Esto eliminará permanentemente \"$name\".';
  }

  @override
  String get switchModeBlockedSnackbar =>
      'Detén la pelea actual antes de cambiar de modo.';

  @override
  String copyOfMode(String name) {
    return 'Copia de $name';
  }

  @override
  String modeRoundsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count asaltos',
      one: '1 asalto',
    );
    return '$_temp0';
  }

  @override
  String workDuration(String duration) {
    return '$duration de trabajo';
  }

  @override
  String restDuration(String duration) {
    return '$duration de descanso';
  }

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get appTagline =>
      'Temporizador de asaltos para entrenamiento de boxeo, MMA y deportes de combate.';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get aboutDescription =>
      'Boxing Timer te ayuda a llevar temporizadores de asaltos estructurados para boxeo, MMA y otros deportes de combate. Configura la duración del calentamiento, los asaltos y los descansos, guarda tus configuraciones favoritas como modos, y entrena con señales de audio al iniciar cada asalto y en los últimos diez segundos de cada uno.';

  @override
  String get contactLabel => 'Desarrollador';

  @override
  String get developerName => 'Danny Vaca';

  @override
  String get developerEmail => 'danny270793@icloud.com';

  @override
  String get developerGithub => 'GitHub';

  @override
  String get developerWebsite => 'Sitio web';

  @override
  String get developerYoutube => 'YouTube';

  @override
  String get developerLinkedin => 'LinkedIn';

  @override
  String get termsTitle => 'Términos y condiciones';

  @override
  String get privacyTitle => 'Política de privacidad';

  @override
  String get termsBody =>
      'Estos Términos y Condiciones (\"Términos\") rigen el uso de Boxing Timer (la \"App\"). Al descargar, instalar o usar la App, aceptas quedar sujeto a estos Términos. Si no estás de acuerdo, no uses la App.\n\n1. Uso de la App\nLa App se ofrece para uso personal y no comercial como temporizador de asaltos para entrenamiento de boxeo, MMA y otros deportes de combate. Eres responsable de usar la App de forma segura y de cualquier lesión o daño derivado de tus actividades de entrenamiento.\n\n2. Cuenta opcional\nPuedes usar la App sin iniciar sesión. Si creas una cuenta, el acceso lo gestiona Supabase. Los modos de entrenamiento y datos similares generados por la app se quedan hoy en este dispositivo. Versiones posteriores podrán guardar esa información en Supabase cuando hayas iniciado sesión, para sincronizarla entre tus dispositivos.\n\n3. No es asesoría profesional\nLa App no brinda asesoría médica, de entrenamiento ni profesional. Consulta a un profesional calificado antes de comenzar cualquier programa de ejercicio.\n\n4. Propiedad intelectual\nTodo el contenido, diseño y código de la App son propiedad del desarrollador salvo que se indique lo contrario, y no pueden copiarse, modificarse ni redistribuirse sin permiso.\n\n5. Exención de garantías\nLa App se ofrece \"tal cual\" y \"según disponibilidad\", sin garantías de ningún tipo.\n\n6. Limitación de responsabilidad\nEn la máxima medida permitida por la ley, el desarrollador no será responsable de daños indirectos, incidentales o consecuentes derivados del uso de la App.\n\n7. Cambios a estos Términos\nEstos Términos pueden actualizarse periódicamente. El uso continuado de la App después de publicar cambios constituye la aceptación de los Términos revisados.';

  @override
  String get privacyBody =>
      'Esta Política de Privacidad explica cómo Boxing Timer (la \"App\") maneja tu información.\n\n1. Cuenta (opcional)\nPuedes usar la App sin cuenta. Si inicias sesión, la autenticación la proporciona Supabase. Tu correo y credenciales los procesa Supabase; esta App no guarda tu contraseña.\n\n2. Qué guardamos hoy — y más adelante\nLos modos de entrenamiento personalizados y las preferencias (tema, idioma, modo seleccionado) se almacenan en este dispositivo. Hoy no subimos datos generados por la app, como modos guardados o favoritos. En el futuro, si has iniciado sesión, podremos guardar ese tipo de información en Supabase para sincronizarla entre tus dispositivos.\n\n3. Sin análisis ni publicidad\nLa App no incluye software de análisis, seguimiento ni publicidad de terceros.\n\n4. Permisos\nLos permisos del dispositivo se limitan a lo necesario para el temporizador, el sonido y el desbloqueo biométrico opcional.\n\n5. Compartir datos\nNo vendemos tu información personal. El inicio de sesión lo procesa Supabase. Si más adelante hay sincronización en la nube, también usaría Supabase.\n\n6. Cambios a esta Política\nEsta Política de Privacidad puede actualizarse periódicamente. El uso continuado de la App después de esos cambios implica la aceptación de la política actualizada.';
}
