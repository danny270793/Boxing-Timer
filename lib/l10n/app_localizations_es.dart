// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Boxing Timer';

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
  String get settingsProfileSection => 'Perfil';

  @override
  String get settingsSecuritySection => 'Seguridad';

  @override
  String get settingsTimerSection => 'Temporizador';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get modesMenuTitle => 'Modos';

  @override
  String get modesMenuSubtitle => 'Asaltos, tiempos y preajustes';

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
  String get biometricLockTitle => 'Boxing Timer está bloqueado';

  @override
  String get biometricLockBody => 'Autentícate para continuar.';

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
  String get settings => 'Configuración';

  @override
  String get settingsChangeEmail => 'Cambiar correo electrónico';

  @override
  String get settingsChangeEmailDialogTitle => 'Cambiar correo electrónico';

  @override
  String get settingsNewEmailLabel => 'Nuevo correo electrónico';

  @override
  String get settingsChangeEmailSubmit => 'Actualizar';

  @override
  String get settingsChangeEmailSuccess =>
      'Revisa tu correo nuevo para confirmar el cambio.';

  @override
  String get settingsChangeEmailInvalid =>
      'Introduce un correo electrónico válido.';

  @override
  String get settingsChangeEmailSameAsCurrent => 'Ese ya es tu correo.';

  @override
  String get settingsChangePassword => 'Cambiar contraseña';

  @override
  String get settingsChangePasswordSubtitle =>
      'Actualiza la contraseña con la que inicias sesión.';

  @override
  String get settingsChangePasswordDialogTitle => 'Cambiar contraseña';

  @override
  String get settingsNewPasswordLabel => 'Nueva contraseña';

  @override
  String get settingsConfirmNewPasswordLabel => 'Confirmar contraseña';

  @override
  String get settingsChangePasswordSubmit => 'Actualizar contraseña';

  @override
  String get settingsChangePasswordSuccess => 'Tu contraseña se actualizó.';

  @override
  String get settingsPasswordsDoNotMatch => 'Las contraseñas no coinciden.';

  @override
  String get settingsPasswordTooShort =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID y huella dactilar';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Requerir autenticación al volver a la aplicación.';

  @override
  String get settingsBiometricUnavailable =>
      'El desbloqueo biométrico no está disponible en este dispositivo.';

  @override
  String get settingsBiometricAuthReason =>
      'Activar desbloqueo biométrico para Boxing Timer';

  @override
  String get settingsBiometricResumeReason => 'Desbloquear Boxing Timer';

  @override
  String get biometricLockUnlockButton => 'Desbloquear';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Predeterminado del sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsAboutApp => 'Acerca de';

  @override
  String get settingsRateApp => 'Calificar en Google Play';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsAboutTagline =>
      'Temporizador de asaltos para entrenamiento de boxeo, MMA y deportes de combate.';

  @override
  String get settingsAboutVersionLabel => 'Versión';

  @override
  String get settingsAboutFeaturesHeading => 'Qué puedes hacer';

  @override
  String get settingsAboutBulletRounds =>
      'Usa temporizadores estructurados de calentamiento, asaltos y descansos para boxeo, MMA y otros deportes de combate.';

  @override
  String get settingsAboutBulletModes =>
      'Parte de los preajustes de boxeo y MMA o guarda tus configuraciones favoritas como modos personalizados.';

  @override
  String get settingsAboutBulletSounds =>
      'Entrena con señales de audio al iniciar cada asalto y en los últimos diez segundos de cada uno.';

  @override
  String get settingsAboutDataHeading => 'Tus datos';

  @override
  String get settingsAboutDataBody =>
      'Los modos de entrenamiento y las preferencias se guardan en este dispositivo. Iniciar sesión es opcional y lo gestiona Supabase.';

  @override
  String get settingsAboutDeveloperHeading => 'Desarrollador';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Sitio web';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyTagline =>
      'Cómo Boxing Timer maneja tu información.';

  @override
  String get settingsPrivacyDataTitle => 'Cuenta (opcional)';

  @override
  String get settingsPrivacyDataBody =>
      'Puedes usar la app sin cuenta. Si inicias sesión, la autenticación la proporciona Supabase. Tu correo y credenciales los procesa Supabase; esta app no guarda tu contraseña.';

  @override
  String get settingsPrivacyInfraTitle => 'Qué guardamos hoy — y más adelante';

  @override
  String get settingsPrivacyInfraBody =>
      'Los modos de entrenamiento personalizados y las preferencias (tema, idioma, modo seleccionado) se almacenan en este dispositivo. Hoy no subimos datos generados por la app, como modos guardados o favoritos. En el futuro, si has iniciado sesión, podremos guardar ese tipo de información en Supabase para sincronizarla entre tus dispositivos.';

  @override
  String get settingsPrivacyAnalyticsTitle => 'Sin análisis ni publicidad';

  @override
  String get settingsPrivacyAnalyticsBody =>
      'La app no incluye software de análisis, seguimiento ni publicidad de terceros.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permisos';

  @override
  String get settingsPrivacyPermissionsBody =>
      'Los permisos del dispositivo se limitan a lo necesario para el temporizador, el sonido y el desbloqueo biométrico opcional.';

  @override
  String get settingsPrivacySharingTitle => 'Compartir datos';

  @override
  String get settingsPrivacySharingBody =>
      'No vendemos tu información personal. El inicio de sesión lo procesa Supabase. Si más adelante hay sincronización en la nube, también usaría Supabase.';

  @override
  String get settingsPrivacyNoticeTitle => 'Cambios a esta política';

  @override
  String get settingsPrivacyNoticeBody =>
      'Esta política de privacidad puede actualizarse periódicamente. El uso continuado de la app después de esos cambios implica la aceptación de la política actualizada.';

  @override
  String get settingsTermsTagline => 'Normas para usar Boxing Timer.';

  @override
  String get settingsTermsAcceptanceTitle => 'Aceptación';

  @override
  String get settingsTermsAcceptanceBody =>
      'Estos términos rigen el uso de Boxing Timer (la \"app\"). Al descargar, instalar o usar la app, aceptas quedar sujeto a estos términos. Si no estás de acuerdo, no uses la app.';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Uso de la app';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'La app se ofrece para uso personal y no comercial como temporizador de asaltos para entrenamiento de boxeo, MMA y otros deportes de combate. Eres responsable de usar la app de forma segura y de cualquier lesión o daño derivado de tus actividades de entrenamiento.';

  @override
  String get settingsTermsAccountTitle => 'Cuenta opcional';

  @override
  String get settingsTermsAccountBody =>
      'Puedes usar la app sin iniciar sesión. Si creas una cuenta, el acceso lo gestiona Supabase. Los modos de entrenamiento y datos similares generados por la app se quedan hoy en este dispositivo. Versiones posteriores podrán guardar esa información en Supabase cuando hayas iniciado sesión, para sincronizarla entre tus dispositivos.';

  @override
  String get settingsTermsDisclaimerTitle => 'No es asesoría profesional';

  @override
  String get settingsTermsDisclaimerBody =>
      'La app no brinda asesoría médica, de entrenamiento ni profesional. Consulta a un profesional calificado antes de comenzar cualquier programa de ejercicio.';

  @override
  String get settingsTermsIpTitle => 'Propiedad intelectual';

  @override
  String get settingsTermsIpBody =>
      'Todo el contenido, diseño y código de la app son propiedad del desarrollador salvo que se indique lo contrario, y no pueden copiarse, modificarse ni redistribuirse sin permiso.';

  @override
  String get settingsTermsLiabilityTitle => 'Garantía y responsabilidad';

  @override
  String get settingsTermsLiabilityBody =>
      'La app se ofrece \"tal cual\" y \"según disponibilidad\", sin garantías de ningún tipo. En la máxima medida permitida por la ley, el desarrollador no será responsable de daños indirectos, incidentales o consecuentes derivados del uso de la app.';

  @override
  String get settingsTermsNoticeTitle => 'Cambios a estos términos';

  @override
  String get settingsTermsNoticeBody =>
      'Estos términos pueden actualizarse periódicamente. El uso continuado de la app después de publicar cambios constituye la aceptación de los términos revisados.';
}
