<template>
  <div class="GameStats">
    <div
      v-if="gameIsWon"
      class="GameStats__victory"
    >
      Вы победили
    </div>
    <template v-else>
      <div class="GameStats__stepsAmount">
        <div class="GameStats__stepsAmount_title">
          Ход
        </div>
        <div class="GameStats__stepsAmount_content">
          {{ step }}
        </div>
      </div>
      <div class="GameStats__timer">
        <div class="GameStats__timer_title">
          Время
        </div>
        <div class="GameStats__timer_content">
          {{ timeElapsedReadable }}
        </div>
      </div>
    </template>

  </div>
</template>

<script>
export default {
  name: 'GameStats',

  props: {
    step: {
      required: true,
      type: Number,
    },
    gameStartedAt: {
      required: true,
      type: Number,
    },
    timerInProgress: Boolean,
    gameIsWon: Boolean,
  },

  data: () => ({
    interval: null,
    secondsElapsed: 0,
  }),

  computed: {
    timeElapsedReadable () {
      let minutes = Math.floor(this.secondsElapsed / 60)
      let seconds = Math.floor(this.secondsElapsed % 60)

      return `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`
    },
  },

  watch: {
    gameStartedAt () {
      this.secondsElapsed = (Date.now() - this.gameStartedAt) / 1000
    },
  },

  created () {
    this.startTimer()
  },

  beforeDestroy () {
    this.stopTimer()
  },

  methods: {
    startTimer () {
      this.stopTimer()
      this.interval = setInterval(() => {
        if (!this.timerInProgress) {
          return
        }
        this.secondsElapsed = (Date.now() - this.gameStartedAt) / 1000
      }, 300)
    },
    stopTimer () {
      if (this.interval !== null) {
        clearInterval(this.interval)
        this.interval = null
      }
    },
  },
}
</script>

<style lang="scss">
  @import '~assets/styles/variables';

  $bgColor: $gameTileBg;

  .GameStats {
    display: flex;
    margin-bottom: 1rem;

    &__stepsAmount, &__timer, &__victory {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 0.4rem;

      font-family: $fontPrimary;
      font-size: 1.4rem;
      background: $bgColor;
    }

    &__stepsAmount, &__timer {
      width: 50%;
    }
    &__victory {
      width: 100%;
    }
  }
</style>
