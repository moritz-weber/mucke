// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class L10nPt extends L10n {
  L10nPt([String locale = 'pt']) : super(locale);

  @override
  String get home => 'Início';

  @override
  String get customizeHomePage => 'Personalizar página inicial';

  @override
  String get settings => 'Opções';

  @override
  String get noSongsYet =>
      'Parece que não tem nenhuma música na sua biblioteca: Vá para as configurações, adicione as suas pastas de música e atualize a sua biblioteca.';

  @override
  String get library => 'Biblioteca';

  @override
  String get search => 'Buscar';

  @override
  String get updateLibrary => 'Atualizar biblioteca';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artistas, $albumCount albums, $songCount músicas';
  }

  @override
  String get scanSuccessful => 'Library scan completed.';

  @override
  String scanFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count scan failures',
      one: '1 scan failure',
    );
    return '$_temp0';
  }

  @override
  String get scanPermissionDenied =>
      'Audio permission required to scan the library.';

  @override
  String get scanErrorDetails => 'Details';

  @override
  String get scanFailures => 'Scan failures';

  @override
  String get scanFailureStage => 'Stage';

  @override
  String get scanStageMetadata => 'Metadata';

  @override
  String get scanStageAlbumArt => 'Album art';

  @override
  String get scanStageAccentColor => 'Accent color';

  @override
  String get scanStagePermission => 'Permission';

  @override
  String get scanErrorMetadata => 'Metadata could not be read.';

  @override
  String get scanErrorAlbumArt => 'Album art could not be read.';

  @override
  String get scanErrorAccentColor => 'Accent color could not be generated.';

  @override
  String get scanErrorPermission => 'Audio permission was denied.';

  @override
  String get manageLibraryFolders => 'Gerir pastas da biblioteca';

  @override
  String get allowedFileExtensions => 'Extensões de ficheiro permitidas';

  @override
  String get allowedFileExtensionsDescription =>
      'Uma lista separada por vírgulas das extensões de ficheiro permitidas. Não importa se tem letras maiúsculas ou minúsculas. Se não tiver certeza sobre isso, use o padrão.';

  @override
  String get manageBlockedFiles => 'Gerir ficheiros bloqueados';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Quantidade de ficheiros atualmente bloqueados: $blockedFiles';
  }

  @override
  String get playback => 'Reprodução';

  @override
  String get playAlbumsInOrder => 'Reproduzir os álbuns em ordem';

  @override
  String get playAlbumsInOrderDescription =>
      'Ao clicar numa música de um álbum, as músicas serão reproduzidas na ordem, em vez de manter o modo de reprodução anterior.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Contar as músicas reproduzidas após: $percentage%';
  }

  @override
  String get libraryFolders => 'Pastas da biblioteca';

  @override
  String get blockedFiles => 'Ficheiros bloqueados';

  @override
  String get homeCustomization => 'Customização do Início';

  @override
  String get albumOfTheDay => 'Álbum do dia';

  @override
  String get artistOfTheDay => 'Artista do dia';

  @override
  String get shuffleAll => 'Baralhar tudo';

  @override
  String get history => 'Histórico';

  @override
  String get addWidgetToHome => 'Adicionar um widget à sua página inicial';

  @override
  String get noPlaylistsYet =>
      'Sem playlists ainda. Pode adicionar na biblioteca.';

  @override
  String get lastPlayed => 'Último reproduzido';

  @override
  String get noHistoryYet => 'Nada para ver aqui. Jogue alguma coisa.';

  @override
  String get allSongs => 'Todas as músicas';

  @override
  String get song => 'Música';

  @override
  String get songs => 'Músicas';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas',
      one: 'uma música',
      zero: 'sem músicas',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Álbum';

  @override
  String get albums => 'Álbuns';

  @override
  String get artist => 'Artista';

  @override
  String get artists => 'Artistas';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get smartlist => 'Lista Inteligente';

  @override
  String get smartlists => 'Listas inteligentes';

  @override
  String get noShuffle => 'Nenhum (manter o modo aleatório atual)';

  @override
  String get normalMode => 'Modo normal';

  @override
  String get shuffleMode => 'Modo aleatório';

  @override
  String get favShuffleMode => 'Modo aleatório de favoritos';

  @override
  String get playlistNormalMode => 'Play from the top';

  @override
  String get playlistShuffleMode => 'Start shuffle playback';

  @override
  String get playlistFavShuffleMode => 'Start favorite shuffle playback';

  @override
  String get name => 'Nome';

  @override
  String get sortingFilterSettings => 'Configurações de classificação e filtro';

  @override
  String get maxNumberEntries => 'Quantidade máxima de entradas';

  @override
  String get creationDate => 'Data de criação';

  @override
  String get changeDate => 'Mudar data';

  @override
  String get lastTimePlayed => 'Última vez tocado';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get both => 'Ambos';

  @override
  String get playlistsOnly => 'Apenas playlists';

  @override
  String get smartlistsOnly => 'Apenas listas inteligentes';

  @override
  String get displaySettings => 'Configurações de ecrã';

  @override
  String get addSmartlist => 'Adicionar lista Inteligente';

  @override
  String get addPlaylist => 'Adicionar playlist';

  @override
  String get createPlaylist => 'Criar playlist';

  @override
  String get editPlaylist => 'Editar Playlist';

  @override
  String get customizeCover => 'Customizar o Cover';

  @override
  String get playbackMode => 'Modo de reprodução';

  @override
  String get excludeAllSongs =>
      'Excluir todas as músicas marcadas para a exclusão.';

  @override
  String get excludeInShuffle =>
      'Excluir músicas marcadas para a exclusão no modo aleatório.';

  @override
  String get excludeAlways =>
      'Exclua apenas músicas marcadas como sempre excluídas.';

  @override
  String get dontExclude => 'Não excluir nenhuma música.';

  @override
  String get filterSettings => 'Filtrar configurações';

  @override
  String filterLikes(int min, int max) {
    return 'Curtidas entre $min e $max';
  }

  @override
  String get minPlayCount => 'Contagem mínima de toques';

  @override
  String get maxPlayCount => 'Contagem máxima de toques';

  @override
  String get minYear => 'Ano mínimo';

  @override
  String get maxYear => 'Ano máximo';

  @override
  String selectArtistsExclude(int num) {
    return 'Selecionar artistas para excluir: $num selecionados.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Selecionar artistas para incluir: $num selecionados.';
  }

  @override
  String get includeAllArtists =>
      'Incluir todos os artistas se nenhum for selecionado.';

  @override
  String get excludeArtists => 'Excluir artistas selecionados';

  @override
  String get limitSongs => 'Limitar quantidade de músicas';

  @override
  String get orderSettings => 'Configurações de pedido';

  @override
  String get orderSettingsDescription =>
      'Reordenar opções para mudar prioridades.';

  @override
  String get createSmartlist => 'Criar lista inteligente';

  @override
  String get editSmartlist => 'Editar lista inteligente';

  @override
  String get play => 'Tocar';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas selecionadas',
      one: 'uma música selecionada',
      zero: 'sem músicas selecionadas',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Tocar o próximo';

  @override
  String get appendToQueued => 'Anexar às músicas em fila manualmente';

  @override
  String get addToQueue => 'Adicionar à fila';

  @override
  String get disc => 'Disco';

  @override
  String get blockFromLibrary => 'Remover e bloquear da biblioteca';

  @override
  String get highlights => 'Destaques';

  @override
  String get shuffle => 'Baralhar';

  @override
  String get selectArtists => 'Selecione Artistas';

  @override
  String get removeFromQueue => 'Remover da fila';

  @override
  String get currentlyPlaying => 'Atualmente tocando';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas',
      one: 'uma música',
      zero: 'sem músicas',
    );
    return '$_temp0 na fila';
  }

  @override
  String moreAvailable(int num) {
    return '$num à mais disponível';
  }

  @override
  String get nameMustNotBeEmpty => 'O nome não deve estar vazio.';

  @override
  String get artistName => 'Nome do artista';

  @override
  String get likeCount => 'Numero de curtidas';

  @override
  String get playCount => 'Reproduções';

  @override
  String get songTitle => 'Título da música';

  @override
  String get year => 'Ano';

  @override
  String get timeAdded => 'Tempo adicionado';

  @override
  String get addToPlaylist => 'Adicionar à playlist';

  @override
  String get removeFromPlaylist => 'Remover da playlist';

  @override
  String get cancel => 'Cancelar';

  @override
  String get nextUp => 'Próxima';

  @override
  String get previousSong => 'anterior';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tocada $count vezes',
      one: 'tocada uma vez',
      zero: 'não tocada ainda',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Sempre tocar música anterior antes';

  @override
  String get alwaysPlayNext => 'Sempre tocar próxima música depois';

  @override
  String get dontExcludeSong => 'Não excluir esta música.';

  @override
  String get excludeShuffleAllSong =>
      'Excluir quando baralhar todas as músicas.';

  @override
  String get excludeShuffleSong => 'Excluir quando baralhar.';

  @override
  String get alwaysExcludeSong => 'Sempre excluir esta canção.';

  @override
  String get welcomeToMucke => 'Bem-vindo ao Mucke!';

  @override
  String get setupLibrary => 'Configurar Biblioteca';

  @override
  String get setupLibraryDescription =>
      'Selecionar pastas, extensões de ficheiros incluídas, etc.';

  @override
  String get importData => 'Importar dados';

  @override
  String get importDataDescription =>
      'Importar os seus dados de uma instalação anterior do mucke.';

  @override
  String get yourLibrary => 'A sua biblioteca:';

  @override
  String get scan => 'Scanear';

  @override
  String get noFoldersSelected => 'Nenhuma pasta selecionada até agora.';

  @override
  String get addFolder => 'Adicionar pasta';

  @override
  String get availableFromImport => 'Disponível dos dados importados:';

  @override
  String get use => 'Usar';

  @override
  String get reset => 'Repor';

  @override
  String get blockedFilesDescription =>
      'Ficheiros bloqueados dos dados importados. Apenas os exatos serão excluídos da verificação da biblioteca. Ficheiros adicionais podem ser bloqueados mais tarde na app.';

  @override
  String get importLibData => 'Importar dados da biblioteca';

  @override
  String get songMetaData => 'Metadados das músicas';

  @override
  String metaDataAvailable(int num) {
    return 'Metadados disponíveis para $num músicas';
  }

  @override
  String get metaDataDescription => 'Importe curtidas, blocos etc.';

  @override
  String get imported => 'Importado';

  @override
  String get importVerb => 'importar';

  @override
  String get miscellaneous => 'Diversos';

  @override
  String get exportData => 'Exportar dados';

  @override
  String get saveLogFiles => 'Save log files';

  @override
  String get saveLogFilesDescription =>
      'This creates a subfolder with the log files in it.';

  @override
  String logFilesSavedTo(String path) {
    return 'Log files saved to:\n$path';
  }

  @override
  String get logFilesSaveFailed => 'Saving log files failed!';

  @override
  String get exportDescription =>
      'Selecione os dados que deseja exportar. Por padrão, tudo é exportado. Ao exportar, pode selecionar uma pasta para o ficheiro a ser armazenado.';

  @override
  String get songsAlbumsArtists => 'Músicas, álbuns e artistas';

  @override
  String get librarySettings => 'Configurações da biblioteca';

  @override
  String dataExportedTo(String path) {
    return 'Dados exportados para:\n$path';
  }

  @override
  String get dataExportFailed => 'A exportação de dados falhou!';

  @override
  String get yourPlaylists => 'As suas playlists';

  @override
  String get systemSettings => 'Configurações do sistema';

  @override
  String get batteryExplanation =>
      'A partir do Android 12, a otimização da pilha causa um erro com a notificação depois de perder o foco do áudio, por exemplo, ao receber uma chamada. Desativar a otimização para o Mucke, resolve este problema.';

  @override
  String get openBattery => 'Abrir configurações da pilha';

  @override
  String get disableBattery =>
      'Desative a otimização no mucke, para resolver problemas na notificação.';

  @override
  String get disableBatteryDescription =>
      'Disabling battery optimization can solve potential notification issues.';

  @override
  String get disabledBattery => 'A otimização de pilha está desativada.';

  @override
  String get manageExternalExplanation =>
      'Conceder esta permissão pode melhorar a velocidade de scans na biblioteca significativamente. Ela não muda o comportamento da app de nenhuma outra forma.';

  @override
  String get grantManagePermission =>
      'Conceder permissão para gerir todos os ficheiros.';

  @override
  String get managePermissionSubtitle =>
      'Revocar a permissão resultará num reinício da app.';

  @override
  String get favorites => 'Favoritos';

  @override
  String get favoritesDesc => 'Contém todas as músicas que gosta.';

  @override
  String get newlyAdded => 'Adicionado recentemente';

  @override
  String get newlyAddedDesc =>
      'Contém as 100 músicas que foram adicionadas por último.';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Avançar';

  @override
  String get finish => 'Finalizar';

  @override
  String get errorReadData => 'Erro a ler dados arquivados.';

  @override
  String get createSmartlists => 'Criar listas inteligentes';

  @override
  String get createSmartlistsDesc =>
      'Criar listas inteligentes sugeridas para melhorar a sua experiência de audição. Pode personalizar estas listas mais tarde.';

  @override
  String get create => 'Criar';

  @override
  String get created => 'Criada';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class L10nPtBr extends L10nPt {
  L10nPtBr() : super('pt_BR');

  @override
  String get home => 'Início';

  @override
  String get customizeHomePage => 'Personalizar página inicial';

  @override
  String get settings => 'Opções';

  @override
  String get noSongsYet =>
      'Parece que você não tem nenhuma música em sua biblioteca: Acesse as configurações, adicione suas pastas de música e atualize sua biblioteca.';

  @override
  String get library => 'Biblioteca';

  @override
  String get search => 'Buscar';

  @override
  String get updateLibrary => 'Atualizar biblioteca';

  @override
  String artistsAlbumsSongs(int artistCount, int albumCount, int songCount) {
    return '$artistCount artistas, $albumCount albums, $songCount músicas';
  }

  @override
  String get manageLibraryFolders => 'Gerenciar pastas da biblioteca';

  @override
  String get allowedFileExtensions => 'Extensões de arquivo permitidas';

  @override
  String get allowedFileExtensionsDescription =>
      'Uma lista separada por vírgulas das extensões de arquivo permitidas. Não importa se em letras maiúsculas ou minúsculas. Se você não tiver certeza sobre isso, use o padrão.';

  @override
  String get manageBlockedFiles => 'Gerenciar arquivos bloqueados';

  @override
  String numberOfBlockedFiles(int blockedFiles) {
    return 'Número de arquivos atualmente bloqueados: $blockedFiles';
  }

  @override
  String get playback => 'Reprodução';

  @override
  String get playAlbumsInOrder => 'Reproduzir os álbuns em ordem';

  @override
  String get playAlbumsInOrderDescription =>
      'Ao clicar em uma música de um álbum, as músicas serão reproduzidas na ordem, em vez de manter o modo de reprodução anterior.';

  @override
  String countSongsPlayed(int percentage) {
    return 'Contar as músicas reproduzidas após: $percentage%';
  }

  @override
  String get libraryFolders => 'Pastas da biblioteca';

  @override
  String get blockedFiles => 'Arquivos bloqueados';

  @override
  String get homeCustomization => 'Customização do Início';

  @override
  String get albumOfTheDay => 'Álbum do dia';

  @override
  String get artistOfTheDay => 'Artista do dia';

  @override
  String get shuffleAll => 'Embaralhar tudo';

  @override
  String get history => 'Histórico';

  @override
  String get addWidgetToHome => 'Adicionar um widget à sua página inicial';

  @override
  String get noPlaylistsYet =>
      'Sem playlists ainda. Você pode adicionar na biblioteca.';

  @override
  String get lastPlayed => 'Último reproduzido';

  @override
  String get noHistoryYet => 'Nada para ver aqui. Jogue alguma coisa.';

  @override
  String get allSongs => 'Todas as músicas';

  @override
  String get song => 'Música';

  @override
  String get songs => 'Músicas';

  @override
  String nSongs(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas',
      one: 'uma música',
      zero: 'sem músicas',
    );
    return '$_temp0';
  }

  @override
  String get album => 'Álbum';

  @override
  String get albums => 'Álbuns';

  @override
  String get artist => 'Artista';

  @override
  String get artists => 'Artistas';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get smartlist => 'Lista Inteligente';

  @override
  String get smartlists => 'Listas inteligentes';

  @override
  String get noShuffle => 'Nenhum (manter o modo aleatório atual)';

  @override
  String get normalMode => 'Modo normal';

  @override
  String get shuffleMode => 'Modo aleatório';

  @override
  String get favShuffleMode => 'Modo aleatório de favoritos';

  @override
  String get name => 'Nome';

  @override
  String get sortingFilterSettings => 'Configurações de classificação e filtro';

  @override
  String get maxNumberEntries => 'Número máximo de entradas';

  @override
  String get creationDate => 'Data de criação';

  @override
  String get changeDate => 'Mudar data';

  @override
  String get lastTimePlayed => 'Última vez tocado';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get both => 'Ambos';

  @override
  String get playlistsOnly => 'Apenas playlists';

  @override
  String get smartlistsOnly => 'Apenas listas inteligentes';

  @override
  String get displaySettings => 'Configurações de tela';

  @override
  String get addSmartlist => 'Adicionar lista Inteligente';

  @override
  String get addPlaylist => 'Adicionar playlist';

  @override
  String get createPlaylist => 'Criar playlist';

  @override
  String get editPlaylist => 'Editar Playlist';

  @override
  String get customizeCover => 'Customizar o Cover';

  @override
  String get playbackMode => 'Modo de reprodução';

  @override
  String get excludeAllSongs =>
      'Excluir todas as músicas marcadas para a exclusão.';

  @override
  String get excludeInShuffle =>
      'Excluir músicas marcadas para a exclusão no modo aleatório.';

  @override
  String get excludeAlways =>
      'Exclua apenas músicas marcadas como sempre excluídas.';

  @override
  String get dontExclude => 'Não excluir nenhuma música.';

  @override
  String get filterSettings => 'Filtrar configurações';

  @override
  String filterLikes(int min, int max) {
    return 'Curtidas entre $min e $max';
  }

  @override
  String get minPlayCount => 'Contagem mínima de toques';

  @override
  String get maxPlayCount => 'Contagem máxima de toques';

  @override
  String get minYear => 'Ano mínimo';

  @override
  String get maxYear => 'Ano máximo';

  @override
  String selectArtistsExclude(int num) {
    return 'Selecionar artistas para excluir: $num selecionados.';
  }

  @override
  String selectArtistsInclude(int num) {
    return 'Selecionar artistas para incluir: $num selecionados.';
  }

  @override
  String get includeAllArtists =>
      'Incluir todos os artistas se nenhum for selecionado.';

  @override
  String get excludeArtists => 'Excluir artistas selecionados';

  @override
  String get limitSongs => 'Limitar número de músicas';

  @override
  String get orderSettings => 'Configurações de pedido';

  @override
  String get orderSettingsDescription =>
      'Reordenar opções para mudar prioridades.';

  @override
  String get createSmartlist => 'Criar lista inteligente';

  @override
  String get editSmartlist => 'Editar lista inteligente';

  @override
  String get play => 'Tocar';

  @override
  String nSongsSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas selecionadas',
      one: 'uma música selecionada',
      zero: 'sem músicas selecionadas',
    );
    return '$_temp0';
  }

  @override
  String get playNext => 'Tocar o próximo';

  @override
  String get appendToQueued => 'Anexar às músicas em fila manualmente';

  @override
  String get addToQueue => 'Adicionar à fila';

  @override
  String get disc => 'Disco';

  @override
  String get blockFromLibrary => 'Remover e bloquear da biblioteca';

  @override
  String get highlights => 'Destaques';

  @override
  String get shuffle => 'Embaralhar';

  @override
  String get selectArtists => 'Selecione Artistas';

  @override
  String get removeFromQueue => 'Remover da fila';

  @override
  String get currentlyPlaying => 'Atualmente tocando';

  @override
  String nSongsInQueue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count músicas',
      one: 'uma música',
      zero: 'sem músicas',
    );
    return '$_temp0 na fila';
  }

  @override
  String moreAvailable(int num) {
    return '$num à mais disponível';
  }

  @override
  String get nameMustNotBeEmpty => 'O nome não deve estar vazio.';

  @override
  String get artistName => 'Nome do artista';

  @override
  String get likeCount => 'Numero de curtidas';

  @override
  String get playCount => 'Reproduções';

  @override
  String get songTitle => 'Título da música';

  @override
  String get year => 'Ano';

  @override
  String get timeAdded => 'Tempo adicionado';

  @override
  String get addToPlaylist => 'Adicionar à playlist';

  @override
  String get removeFromPlaylist => 'Remover da playlist';

  @override
  String get cancel => 'Cancelar';

  @override
  String get nextUp => 'Próxima';

  @override
  String get previousSong => 'anterior';

  @override
  String playedNTimes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tocada $count vezes',
      one: 'tocada uma vez',
      zero: 'não tocada ainda',
    );
    return '$_temp0';
  }

  @override
  String get alwaysPlayPrevious => 'Sempre tocar música anterior antes';

  @override
  String get alwaysPlayNext => 'Sempre tocar próxima música depois';

  @override
  String get dontExcludeSong => 'Não exclua esta música.';

  @override
  String get excludeShuffleAllSong =>
      'Exclua quando embaralhar todas as músicas.';

  @override
  String get excludeShuffleSong => 'Exclua quando embaralhar.';

  @override
  String get alwaysExcludeSong => 'Sempre exclua esta música.';

  @override
  String get welcomeToMucke => 'Bem-vindo ao Mucke!';

  @override
  String get setupLibrary => 'Preparar Biblioteca';

  @override
  String get setupLibraryDescription =>
      'Selecione pastas, extensões de arquivo incluídas, etc.';

  @override
  String get importData => 'Importar dados';

  @override
  String get importDataDescription =>
      'Importar seus dados de uma instalação anterior do mucke.';

  @override
  String get yourLibrary => 'Sua biblioteca:';

  @override
  String get scan => 'Scanear';

  @override
  String get noFoldersSelected => 'Nenhuma pasta selecionada até agora.';

  @override
  String get addFolder => 'Adicionar pasta';

  @override
  String get availableFromImport => 'Disponível através dos dados importados:';

  @override
  String get use => 'Usar';

  @override
  String get reset => 'Resetar';

  @override
  String get blockedFilesDescription =>
      'Arquivos bloqueados dos dados importados. Apenas os exatos serão excluídos da verificação da biblioteca. Arquivos adicionais podem ser bloqueados mais tarde no aplicativo.';

  @override
  String get importLibData => 'Importar dados da biblioteca';

  @override
  String get songMetaData => 'Metadados das músicas';

  @override
  String metaDataAvailable(int num) {
    return 'Metadados disponíveis para $num músicas';
  }

  @override
  String get metaDataDescription => 'Importe curtidas, blocos etc.';

  @override
  String get imported => 'Importado';

  @override
  String get importVerb => 'importar';

  @override
  String get miscellaneous => 'Diversos';

  @override
  String get exportData => 'Exportar dados';

  @override
  String get exportDescription =>
      'Selecione os dados que deseja exportar. Por padrão, tudo é exportado. Ao exportar, você pode selecionar uma pasta para o arquivo a ser armazenado.';

  @override
  String get songsAlbumsArtists => 'Músicas, álbuns e artistas';

  @override
  String get librarySettings => 'Configurações da biblioteca';

  @override
  String dataExportedTo(String path) {
    return 'Dados exportados para:\n$path';
  }

  @override
  String get dataExportFailed => 'A exportação de dados falhou!';

  @override
  String get yourPlaylists => 'Suas playlists';

  @override
  String get systemSettings => 'Configuração do sistema';

  @override
  String get batteryExplanation =>
      'A partir do Android 12, a otimização da bateria causa um erro com a notificação depois de perder o foco do áudio, por exemplo, ao receber uma chamada. Desativar a otimização para o Mucke, resolve este problema.';

  @override
  String get openBattery => 'Abrir configurações da bateria';

  @override
  String get disableBattery =>
      'Desative a otimização no mucke, para resolver problemas na notificação.';

  @override
  String get disabledBattery => 'A otimização de bateria está desativada.';

  @override
  String get manageExternalExplanation =>
      'Conceder essa permissão pode melhorar a velocidade de scans na biblioteca significativamente. Ela não muda o comportamento do aplicativo de nenhuma outra forma.';

  @override
  String get grantManagePermission =>
      'Conceder permissão para gerenciar todos os arquivos.';

  @override
  String get managePermissionSubtitle =>
      'Revocar a permissão resultará num reinício do app.';

  @override
  String get favorites => 'Favoritos';

  @override
  String get favoritesDesc => 'Contém todas as músicas que você gosta.';

  @override
  String get newlyAdded => 'Adicionado recentemente';

  @override
  String get newlyAddedDesc =>
      'Contém as 100 músicas que foram adicionadas por último.';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Avançar';

  @override
  String get finish => 'Finalizar';

  @override
  String get errorReadData => 'Erro lendo dados arquivados.';

  @override
  String get createSmartlists => 'Criar listas inteligentes';

  @override
  String get createSmartlistsDesc =>
      'Criar listas inteligentes sugeridas para melhorar sua experiência de audição. Você pode personalizar essas listas mais tarde.';

  @override
  String get create => 'Criar';

  @override
  String get created => 'Criada';
}
